# Research on Grid Scheduling Mechanism Design for Virtual Power Plant Cluster

This repository contains the code, data, and documentation for my undergraduate graduation thesis at Shanghai Jiao Tong University (上海交通大学). The thesis focuses on grid scheduling mechanism design for virtual power plant clusters, with emphasis on subject differentiation, regulation quality evaluation, market clearing mechanisms, and cluster scheduling frameworks.

## 📋 Overview

This research project investigates grid scheduling mechanisms for Virtual Power Plant (VPP) clusters, with a focus on **subject differentiation** as the core concept. The research addresses:

- **Regulation Quality Evaluation** (调节质量评价): Multi-dimensional evaluation system for quantifying differences between VPPs and conventional power plants
- **Market Clearing Mechanisms** (市场出清机制): Multi-objective optimization incorporating regulating quality parameters in peaking markets
- **Compensation Mechanisms** (补偿机制): VCG-based compensation design to motivate quality declarations
- **VPP Cluster Scheduling Framework** (虚拟电厂集群调度框架): Cloud-cluster-end collaborative scheduling architecture for VPP clusters

The thesis proposes a comprehensive framework that quantifies differences, introduces differences into market mechanisms, and distinguishes between subjects in cluster scheduling decisions.

## 📁 Project Structure

```
graduation-thesis/
├── data/
│   ├── MatlabCode/          # MATLAB optimization scripts
│   │   ├── C1.m, C2.m, C20.m # Regulation quality models
│   │   ├── Q.m, Q2.m         # Quality optimization
│   │   ├── T0.m - T4.m       # Test and optimization scripts
│   │   ├── *.xlsx            # Data files
│   │   └── 代号说明.txt      # Code notation reference
│   ├── OriginFile/           # Origin plotting files (.opju)
│   └── ZoteroCSL/            # Citation style files
├── docs/
│   ├── 1-introduction/       # Chapter 1: Introduction
│   ├── 2-regulating-quality/ # Chapter 2: Regulation Quality
│   ├── 3-peak-clearance/     # Chapter 3: Peak Clearance
│   ├── 4-scheduling-framework/# Chapter 4: Scheduling Framework
│   ├── Thesis.pdf            # Main thesis document
│   └── Defense.pptx          # Defense presentation
└── src/
    └── official-tamplates/   # University templates and guidelines
```

## 🔧 Requirements

### Software Dependencies
- **MATLAB** (R2020b or later recommended)
- **YALMIP** - Optimization modeling toolbox
- **CPLEX** - Linear programming solver (or compatible solver)
- **Microsoft Excel** - For data input/output
- **Origin** (optional) - For data visualization

### MATLAB Toolboxes
- Optimization Toolbox
- YALMIP toolbox (included in `docs/3-peak-clearance/YALMIP-master.zip`)

## 🚀 Getting Started

### 1. Install Dependencies

1. Install MATLAB (R2020b or later)
2. Install CPLEX solver
3. Add YALMIP to MATLAB path:
   ```matlab
   addpath(genpath('path/to/YALMIP'))
   ```

### 2. Configure Paths

Before running the scripts, update the file paths in the MATLAB code to match your local directory structure. The scripts currently contain hardcoded paths that need to be adjusted.

Example modification in `C1.m`:
```matlab
% Change from:
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',...)

% To your local path:
xlswrite('path/to/your/data/Q-ep.xlsx',...)
```

### 3. Run Optimization Scripts

The main optimization scripts are located in `data/MatlabCode/`:

- **`Q.m`**: Quality optimization with epsilon constraints
- **`C1.m`**: Market clearing without quality constraints
- **`C2.m`**: Market clearing with quality constraints (single run)
- **`C20.m`**: Market clearing with quality constraints (multiple runs)
- **`C3.m`**: Peak regulation optimization (single run)
- **`C30.m`**: Peak regulation optimization (multiple runs)

Run a script in MATLAB:
```matlab
cd('data/MatlabCode')
Q  % or C1, C2, etc.
```

## 📊 Code Description

### Main Scripts

| Script | Description |
|--------|-------------|
| `Q.m` | Optimizes power quality parameters with epsilon constraints, iterating over 201 epsilon values |
| `C1.m` | Market clearing optimization without quality constraints for 24-hour periods |
| `C2.m` | Market clearing with quality constraints (single optimization run) |
| `C20.m` | Market clearing with quality constraints (multiple optimization runs) |
| `C3.m` | Peak regulation optimization considering quality (single run) |
| `C30.m` | Peak regulation optimization considering quality (multiple runs) |

### Code Notation

See `data/MatlabCode/代号说明.txt` for variable naming conventions:
- `C1`: No quality constraints
- `C2`: With quality constraints, single run
- `C20`: Multiple runs
- `C3`: Peak regulation, single run
- `C30`: Peak regulation, multiple runs

## 📈 Data Files

- **`date1.xlsx`, `date2.xlsx`, etc.**: Input data for optimization models
- **`Q-ep.xlsx`, `Q-ep-2.xlsx`**: Output data for quality-epsilon analysis
- **Origin files (`.opju`)**: Visualization files for plotting results

## 📚 Documentation

- **`docs/Thesis.docx`**: Main thesis document (in Chinese)
- **`docs/Defense.pptx`**: Defense presentation slides
- Chapter-specific documentation in respective folders:
  - Chapter 1: Introduction and organization structure
  - Chapter 2: Regulation quality models and calculations
  - Chapter 3: Peak clearance and multi-objective optimization
  - Chapter 4: Scheduling framework for virtual power plants

## 🔬 Research Topics

### Chapter 2: Regulation Quality and Regulatory Characteristics
- Deconstructs regulating quality from five dimensions: flexibility, reliability, stability, economy, and environmental protection
- Establishes quantifiable indicators under each dimension with weighted evaluation using fuzzy AHP and entropy weight method
- Constructs multi-dimensional comprehensive evaluation system for VPPs and conventional power plants
- Proposes optimization model for distributed resource aggregation with goal of maximizing regulating quality

### Chapter 3: Market Clearing with Regulating Quality
- Improves traditional peaking market clearing model by incorporating regulating quality parameters
- Transforms single-objective economic optimization into multi-objective optimization (economy and quality)
- Proposes decision point selection basis for trade-off between economy and quality
- Designs compensation mechanism based on VCG mechanism and substitution degree concept

### Chapter 4: VPP Cluster Scheduling Framework
- Introduces concepts of Comprehensive VPPs and Specialized VPPs
- Establishes cluster organizational structure with varying scheduling strategies (day-ahead, intra-day, real-time)
- Proposes cloud management platform for VPP cluster
- Constructs grid scheduling framework tailored to VPP cluster based on cloud-group-end architecture

## 📝 Notes

- All code comments and documentation are primarily in Chinese
- File paths in scripts need to be updated to match your local environment
- The optimization models use YALMIP with CPLEX solver
- Results are exported to Excel files for further analysis

## 📄 License

This is an academic research project. Please cite appropriately if you use any part of this work.

## 👤 Author Information

- **Author**: Zeng Deyang
- **Supervisor**: Li Jiamei
- **School**: School of Electronic Information and Electrical Engineering
- **Institution**: Shanghai Jiao Tong University
- **Date**: May 2024

## 📖 Abstract

For the complete English abstract, please see [Summary.md](Summary.md).

---

**Note**: This repository is for academic purposes. Some data files and results may be omitted for privacy or size considerations.

**Disclaimer**: All work of this Graduation Thesis was made by author without any AI Tools. This README.md file was generated with the assistance of AI. The content has been reviewed and verified by the author, but please refer to the actual thesis document and code for authoritative information.
