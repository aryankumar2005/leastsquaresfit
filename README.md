# MATLAB Curve Fitting: Predicting Used EV Prices from Battery Range

## Background

As the automotive industry shifts toward electric vehicles, traditional mileage-based 
pricing models may not apply. Unlike combustion engines, EVs degrade primarily through 
battery wear. This project investigates whether **remaining battery range** is a better 
predictor of used Nissan Leaf prices than mileage.

Data: 28 Nissan Leaf listings from AutoTrader (07/09/2021).

## Files

| File | Description |
|---|---|
| `extract.m` | Loads `CarData.dat` and returns a clean MATLAB table |
| `least_squares_linear.m` | Fits `Cost = m*Range + c` using normal equations |
| `least_squares_quadratic.m` | Fits `Cost = c0 + c1*Range + c2*Range^2` using a design matrix |
| `least_squares_exponential.m` | Fits `Cost = a*exp(b*Range)` via log-linearisation |
| `least_squares_logarithmic.m` | Fits `Cost = m*ln(Range) + c` via log-linearisation |
| `script_C.m` | Runs all four models, computes RMSE, plots results |
| `CarData.dat` | Raw data (Year, Cost, Mileage, Range, SellerType) |

## How to Run

Place all `.m` files and `CarData.dat` in the same directory, then run in MATLAB:

```matlab
data   = extract();
models = script_C(data)
```

The comparison plot appears automatically. `models.BestModel` returns the index of 
the lowest RMSE model (1=Linear, 2=Quadratic, 3=Exponential, 4=Logarithmic).

## Methods

All models are fitted using least squares — minimising the sum of squared residuals 
between predicted and actual prices.

| Model | Equation | Approach |
|---|---|---|
| Linear | `Cost = m*Range + c` | Normal equations built from scalar sums |
| Quadratic | `Cost = c0 + c1*Range + c2*Range^2` | Vandermonde design matrix |
| Exponential | `Cost = a*exp(b*Range)` | Log-linearisation: fit `ln(Cost)` vs Range |
| Logarithmic | `Cost = m*ln(Range) + c` | Log-linearisation: fit Cost vs `ln(Range)` |

Models are compared by **RMSE** (root mean squared error in £). Lower RMSE = better 
in-sample fit.

## Results

Run `script_C(extract())` to see the RMSE comparison and plot. The quadratic model 
produces the lowest RMSE on this dataset.
