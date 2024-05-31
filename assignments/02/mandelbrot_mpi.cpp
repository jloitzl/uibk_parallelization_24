#include <bits/chrono.h>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <chrono>
#include <sys/time.h>
#include <tuple>
#include <vector>
#include <mpi.h>

// Include that allows to print result as an image
// Also, ignore some warnings that pop up when compiling this as C++ mode
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wmissing-field-initializers"
#pragma GCC diagnostic ignored "-Wstringop-overflow"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"
#pragma GCC diagnostic pop

constexpr int default_size_x = 1344; // divisible by 96, since that's how many ranks we have on lcc3
constexpr int default_size_y = 768;

// RGB image will hold 3 color channels
constexpr int num_channels = 3;
// max iterations cutoff
constexpr int max_iterations = 10000;

#define IND(Y, X, SIZE_Y, SIZE_X, CHANNEL) (Y * SIZE_X * num_channels + X * num_channels + CHANNEL)

size_t index(int y, int x, int /*size_y*/, int size_x, int channel) {
	return y * size_x * num_channels + x * num_channels + channel;
}

using Image = std::vector<uint8_t>;

auto HSVToRGB(double H, const double S, double V) {
	if (H >= 1.0) {
		V = 0.0;
		H = 0.0;
	}

	const double step = 1.0 / 6.0;
	const double vh = H / step;

	const int i = (int)floor(vh);

	const double f = vh - i;
	const double p = V * (1.0 - S);
	const double q = V * (1.0 - (S * f));
	const double t = V * (1.0 - (S * (1.0 - f)));
	double R = 0.0;
	double G = 0.0;
	double B = 0.0;

	// clang-format off
	switch (i) {
	case 0: { R = V; G = t; B = p; break; }
	case 1: { R = q; G = V; B = p; break; }
	case 2: { R = p; G = V; B = t; break; }
	case 3: { R = p; G = q; B = V; break; }
	case 4: { R = t; G = p; B = V; break; }
	case 5: { R = V; G = p; B = q; break; }
	}
	// clang-format on

	return std::make_tuple(R, G, B);
}

void calcMandelbrot(Image &image, int size_x, int size_y, int chunk_size) {

	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	auto time_start = std::chrono::high_resolution_clock::now();
	
	const float left = -2.5, right = 1;
	const float bottom = -1, top = 1;

	// TODOs for MPI parallelization
	// 1) domain decomposition
	//   - decide how to split the image into multiple parts
	//   - ensure every rank is computing its own part only
	// 2) result aggregation
	//   - aggregate the individual parts of the ranks into a single, complete image on the root rank (rank 0)


	// split array, then scatter and that's it? do printf to test distribution
	// finally use gather to collect them again, but how do you reconstruct correctly?

	//if (size_x % numprocs != 0) {
	//	MPI_Finalize();
	//	printf("Not divisible by number of ranks, choose from 1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 768");
	//	return EXIT_FAILURE;
	//}

	for (int pixel_y = rank * chunk_size; pixel_y < (rank + 1) * chunk_size; pixel_y++) {
		assert (pixel_y < size_y);
		// scale y pixel into mandelbrot coordinate system
		printf("Hello from rank %d, calculating y-pixel %d \n",rank,pixel_y);
		const float cy = (pixel_y / (float)size_y) * (top - bottom) + bottom;
		for (int pixel_x = 0; pixel_x < size_x; pixel_x++) {
			// scale x pixel into mandelbrot coordinate system
			const float cx = (pixel_x / (float)size_x) * (right - left) + left;
			float x = 0;
			float y = 0;
			int num_iterations = 0;

			// Check if the distance from the origin becomes
			// greater than 2 within the max number of iterations.
			while ((x * x + y * y <= 2 * 2) && (num_iterations < max_iterations)) {
				float x_tmp = x * x - y * y + cx;
				y = 2 * x * y + cy;
				x = x_tmp;
				num_iterations += 1;
			}

			// Normalize iteration and write it to pixel position
			double value = fabs((num_iterations / (float)max_iterations)) * 200;

			auto [red, green, blue] = HSVToRGB(value, 1.0, 1.0);

			int channel = 0;
			image[index(pixel_y, pixel_x, size_y, size_x, channel++)] = (uint8_t)(red * UINT8_MAX);
			image[index(pixel_y, pixel_x, size_y, size_x, channel++)] = (uint8_t)(green * UINT8_MAX);
			image[index(pixel_y, pixel_x, size_y, size_x, channel++)] = (uint8_t)(blue * UINT8_MAX);
		}
	}
	
	auto time_end = std::chrono::high_resolution_clock::now();
	auto time_elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(time_end - time_start).count();

	std::cout << "Mandelbrot set calculation for " << size_x << "x" << size_y << " took: " << time_elapsed << " ms." << std::endl;
}

int main(int argc, char **argv) {
	int size_x = default_size_x;
	int size_y = default_size_y;

	if (argc == 3) {
		size_x = atoi(argv[1]);
		size_y = atoi(argv[2]);
		std::cout << "Using size " << size_x << "x" << size_y << std::endl;
	} else {
		std::cout << "No arguments given, using default size " << size_x << "x" << size_y << std::endl;
	}

	Image image(num_channels * size_x * size_y);

	MPI_Init(&argc, &argv);

	int size;
	MPI_Comm_size(MPI_COMM_WORLD, &size);
	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	int chunk_size = size_y / size;

	calcMandelbrot(image, size_x, size_y, chunk_size);

	//uint8_t localval[2] = {1, 1};
	//uint8_t *arr = (uint8_t *)malloc(16 * sizeof(uint8_t));

	//Image rcv_image(num_channels * size_x * size_y);
	//if (rank == 0) {
	//	int *rcv_image;
	uint8_t *rcv_image = (uint8_t *)malloc(size * num_channels * size_x * size_y * sizeof(uint8_t));
	//Image rcv_image(8 * num_channels * size_x * size_y);
	//}
	//MPI_Gather(&localval, 2, MPI_UINT8_T, arr, 2, MPI_UINT8_T, 0, MPI_COMM_WORLD);
	MPI_Gather(&image[rank * (size_x * chunk_size * num_channels)], size_x * chunk_size * num_channels, MPI_UINT8_T, rcv_image, size_x * chunk_size * num_channels, MPI_UINT8_T, 0, MPI_COMM_WORLD);
	
	if (rank == 0) {
		//for (int i = 0; i < 16; i++) {
		//	std::cout << "gathered ranks" << arr[i] << std::endl;
		//}
		constexpr int stride_bytes = 0;
		stbi_write_png("mandelbrot_mpi.png", size_x, size_y, num_channels, rcv_image, stride_bytes);
	}

	//constexpr int stride_bytes = 0;
	//const char *name = std::to_char(rank);
	//stbi_write_png(name, size_x, size_y, num_channels, image.data(), stride_bytes);

	MPI_Finalize();
	return EXIT_SUCCESS;
}
