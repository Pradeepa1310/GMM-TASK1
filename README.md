<img width="1000" height="800" alt="Dataset" src="https://github.com/user-attachments/assets/193d7e9d-9b8f-49e7-9fe9-7048e46a31cd" /># Gaussian Mixture Model (GMM) Using Expectation-Maximization (EM) Algorithm

## 📌 Project Overview

This project implements a **Gaussian Mixture Model (GMM)** from scratch using the **Expectation-Maximization (EM) Algorithm** in **R Programming Language** without relying on external machine learning libraries.

The objective of this project is to perform **unsupervised clustering** and **density estimation** by modeling data as a mixture of multiple Gaussian distributions. The EM algorithm iteratively estimates hidden cluster memberships and updates model parameters until convergence.

The project demonstrates the complete workflow of a GMM, including dataset generation, parameter initialization, probability density computation, expectation and maximization steps, convergence analysis, cluster assignment, and visualization.

---

# 🎯 Objectives

* Generate synthetic Gaussian-distributed datasets.
* Implement Gaussian Mixture Model from scratch.
* Apply the Expectation-Maximization (EM) algorithm.
* Perform probabilistic clustering.
* Estimate Gaussian distribution parameters.
* Analyze model convergence using Log-Likelihood.
* Visualize clustering results.

---

# 🏗️ Project Structure

```text
GMM-EM-Algorithm/
│
├── synthetic_data_20000.csv
│
├── Output/
│   ├── Dataset.png
│   ├── Final_Clusters.png
│   ├── LogLikelihood.png
│   └── GMM_Cluster_Output.csv
│
├── gmm_em_algorithm.R
│
└── README.md
```

---

# 📊 Dataset Generation

The dataset consists of two Gaussian clusters generated manually using Cholesky decomposition.

### Cluster 1

Mean Vector:

```text
μ₁ = [2, 3]
```

Covariance Matrix:

```text
Σ₁ =
[1.0  0.5]
[0.5  1.0]
```

### Cluster 2

Mean Vector:

```text
μ₂ = [7, 8]
```

Covariance Matrix:

```text
Σ₂ =
[ 1.0 -0.3]
[-0.3  1.0]
```

### Dataset Size

```text
Total Records : 20,000
Cluster 1     : 10,000
Cluster 2     : 10,000
Features      : 2
```

---

# ⚙️ Technologies Used

* R Programming Language
* Matrix Operations
* Statistical Modeling
* Gaussian Distributions
* Expectation-Maximization Algorithm
* Data Visualization

---

# 🧠 Gaussian Mixture Model (GMM)

A Gaussian Mixture Model assumes that data is generated from multiple Gaussian distributions.

Mathematically,

```text
P(x) = Σ πₖ × N(x | μₖ, Σₖ)
```

Where:

| Symbol | Description           |
| ------ | --------------------- |
| πₖ     | Mixing Coefficient    |
| μₖ     | Mean Vector           |
| Σₖ     | Covariance Matrix     |
| N      | Gaussian Distribution |
| K      | Number of Clusters    |

---

# 🔄 EM Algorithm Workflow

The Expectation-Maximization algorithm consists of two major steps.

## Step 1: Initialization

Initialize:

```text
πₖ = 1/K

μₖ = Random data points

Σₖ = Identity Matrix
```

---

## Step 2: Expectation Step (E-Step)

Compute responsibility values.

```text
γᵢₖ =
[ πₖ × N(xᵢ | μₖ, Σₖ) ]
----------------------------------
Σ [ πⱼ × N(xᵢ | μⱼ, Σⱼ) ]
```

Purpose:

* Calculates probability of a point belonging to each cluster.
* Produces soft cluster assignments.

---

## Step 3: Maximization Step (M-Step)

Update model parameters.

### Mixing Coefficient

```text
πₖ = Nₖ / n
```

### Mean Update

```text
μₖ =
(1/Nₖ) Σ γᵢₖ xᵢ
```

### Covariance Update

```text
Σₖ =
(1/Nₖ) Σ γᵢₖ (xᵢ−μₖ)(xᵢ−μₖ)ᵀ
```

Purpose:

* Maximizes expected likelihood.
* Refines cluster parameters.

---

## Step 4: Log-Likelihood Calculation

```text
logL =
Σ log(
Σ πₖ N(xᵢ | μₖ, Σₖ)
)
```

Purpose:

* Measures model performance.
* Monitors convergence.

---

## Step 5: Convergence Check

Algorithm stops when:

```text
| LogL(new) - LogL(old) | < 0.0001
```

or maximum iterations are reached.

---

# 📈 Output Visualizations

The project generates the following outputs:

### 1. Dataset Visualization

Shows the generated Gaussian data points.

```text
Dataset.png
```

### 2. Final Cluster Visualization

Displays clustered data after EM convergence.

```text
Final_Clusters.png
```

### 3. Log-Likelihood Curve

Shows convergence behavior of the model.

```text
LogLikelihood.png
```

### 4. Cluster Output File

Contains:

* Feature 1
* Feature 2
* Assigned Cluster

```text
GMM_Cluster_Output.csv
```

---

# 📋 Algorithm Flow

```text
Start
  │
  ▼
Generate Dataset
  │
  ▼
Initialize Parameters
  │
  ▼
E-Step
  │
  ▼
M-Step
  │
  ▼
Compute Log-Likelihood
  │
  ▼
Convergence Check
  │
  ├── No ──► Repeat EM Steps
  │
  └── Yes
          │
          ▼
Assign Clusters
          │
          ▼
Generate Visualizations
          │
          ▼
End
```

---

# 🚀 How to Run

### Clone Repository

```bash
git clone <repository-url>
```

### Open R Environment

```r
source("gmm_em_algorithm.R")
```

### Execute Script

The program will automatically:

1. Generate the dataset.
2. Train the GMM model.
3. Perform clustering.
4. Create output files.
5. Save visualizations.

---

# 📌 Applications of GMM

* Customer Segmentation
* Pattern Recognition
* Anomaly Detection
* Image Segmentation
* Data Clustering
* Density Estimation
* Market Analysis
* Bioinformatics

---

# 📚 Learning Outcomes

After completing this project, users will understand:

* Gaussian Distributions
* Probability Density Functions
* Expectation-Maximization Algorithm
* Soft Clustering
* Covariance Matrices
* Density Estimation
* Unsupervised Machine Learning
* Statistical Data Analysis

---

# 👨‍💻 Author

**D. Pradeepa**

Bachelor of Computer Applications (BCA)

Kamaraj College, Thoothukudi

Academic Project – Gaussian Mixture Model using EM Algorithm

---

# 📄 License

This project is developed for educational and academic learning purposes.

Output:
Dataset inmage:

<img width="1000" height="800" alt="Dataset" src="https://github.com/user-attachments/assets/c435dbab-74fa-4ae0-9ff4-c88f7cc1f99d" />

final Cluster:

<img width="1000" height="800" alt="Final_Clusters" src="https://github.com/user-attachments/assets/5a0a571a-8110-40d2-bbcb-9bf006e2d94f" />

LogLikelihood:

<img width="1000" height="800" alt="LogLikelihood" src="https://github.com/user-attachments/assets/58d97429-f6ee-4333-9c7a-9b450caa2b54" />






