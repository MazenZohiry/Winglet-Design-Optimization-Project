# Winglet-Design-Optimization-Project

![image](https://user-images.githubusercontent.com/64721988/189901696-3ce4abcb-38ab-4354-857e-26f508b09ff2.png)

The optimization problem in hand entails a multi-objective function comprised of an induced drag element $C_{D_{i}}$ and a wing structural weight element, where the wing structural weight can be assumed to be proportional to the root bending moment $M_{r}$. The induced drag is an inherent output of the problem model which is described in more details in the subsequent section. The root bending moment however has to be computed externally using the lift distribution over each wing element obtained using the model. The root bending moment $M_{r}$ is defined as the integral of the vertical shear force over the span and can be expressed as, 
$M = \int_{0}^{b/2} S(y) dy$

where the vertical shear force itself is acquired through integrating the lift distribution obtained by the model. This is done using a quadrature rule implemented in.

$S = \int_{0}^{b/2} C_{l}  c q dy$

where $q$ is the dynamic pressure, $C_{l}$ is the lift coefficient of the airfoil and $c$ is the chord length at each wing section.

In this study, the effect of an added winglet on both the induced drag $C_{D_{i}}$ and the root bending moment $M_{r}$ is investigated. Consequently, the design of a winglet is to be optimized to minimize an objective function that is based on both the induced drag $C_{D_{i}}$ and the root bending moment $M_{r}$ (a multi-objective optimization) for a planar wing. The multi-objective function can be written as the weighted sum of the scaled individual objectives as:

$J=k \frac{C_{D_{i}}}{C_{D_{i_{0}}}} + (1-k) \frac{M_{r}}{M_{r_{0}}}$

Where $C_{D_{i_{0}}}$ and $M_{r_{0}}$ are the induced drag and root bending moment of the planar (winglet-free) wing, respectively. 

The factor $k$ is a weighting coefficient that signifies the relative importance of the objective function components and varies between 0 and 1.

# Model Walkthrough

The implementation of the optimizer is done in Matlab and AVL using several scripts, the first being *Datafile.m* which is used to define the planar winglet geometry as well as the reference geometric and flight parameters discussed earlier. The scripts named *Gen_AVL_inputfile.m* and *Gen_AVL_case.m*, as the names indicate, are responsible for constructing the input and case files needed to run an AVL session, respectively. Additionally, the *Gen_AVL_case.m* script manages the location folders where the results files (load files) are being stored. Moreover, the *Exec_AVL.m* script executes the program and passes the input files which in turn outputs results file from which the loads and the induced drag can be extracted. The *data_discipline* is a where the data is extracted from the results files and the root bending moment $M_{r}$ is computed by integrating the vertical shear force over the span. The output of this script is simply $C_{D_{i}}$ and $M_{r}$ which are then passed to another script called *Cost_function.m*. This script in turn computes the objective function *J* based on the computed quantities. Finally, the script *main_run* is used to call the previously mentioned scripts and also to initialize the optimization process.

<img src="https://user-images.githubusercontent.com/64721988/191049929-d3ae9bc0-a4d9-4aad-9b77-89439da98a6d.png" width=40% height=40%>
