# Simple CNN Convolution Layer Accelerator in Verilog

This project is a hardware accelerator for a 3x3 2D convolution, designed and verified entirely in Verilog. The 2D convolution is the core mathematical operation used in Convolutional Neural Networks (CNNs) for image processing and computer vision.

This accelerator is designed as a software-only, simulation-based project.
## Features
-   Implements a 3x3 convolution engine for 8-bit grayscale pixel data.
-   Modular architecture with separate modules for control, memory, and processing.
-   Control logic is implemented with a robust Finite State Machine (FSM).
-   Correctly handles the one-clock-cycle read latency of synchronous memories (like FPGA Block RAMs).
-   Includes a complete verification environment with unit and integration-level testbenches.
-   The design is fully synthesizable.

## Architecture
The accelerator is composed of three main modules integrated into a top-level design:
1.  **`control_unit`**: An FSM-based controller that orchestrates the data flow. It generates addresses for the memory and control signals for the datapath.
2.  **`image_memory`**: A synchronous-read memory block, pre-loaded with sample image data for the simulation.
3.  **`single_pixel_conv`**: A purely combinational processing element that performs the nine multiply-accumulate (MAC) operations for a single output pixel.

A 3x3 register file (`pixel_patch`) is used in the top-level module to buffer the pixel data between the single-port memory and the parallel-input processing element.

