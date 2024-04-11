#include "solver/limiter.hpp"

#include <algorithm>
#include <iostream>

limiter_base::limiter_base() {}

limiter_minmod::limiter_minmod(double theta) { this->theta = theta; }

double limiter_minmod::compute(double first, double second, double third) {

	double outval = 0.0;
	if (first * second < 0 or first * third < 0) {
		outval = 0.0;
	} else {
		if (first < 0) {
			double tmp_max = std::max(first, second);
			outval = std::max(tmp_max, third);
		}
		else {
			double tmp_min = std::min(first, second);
			outval = std::min(tmp_min, third);
		}
	}
	return outval;
}