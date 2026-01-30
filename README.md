# Simple CNN Convolution Layer Accelerator (Verilog)

This project implements a **hardware accelerator for a 3×3 2D convolution**, designed in **Verilog**.
The 2D convolution operation is a core building block in **Convolutional Neural Networks (CNNs)** used for image processing and computer vision applications.

The accelerator was developed as an RTL design, functionally verified through simulation, and later integrated with a **Zynq SoC** using an **AXI4-Lite interface** as part of a hardware–software co-design flow.

---

## Features

* Implements a **3×3 convolution engine** for 8-bit grayscale pixel data
* Uses **parallel multiply–accumulate (MAC) operations** for pixel computation
* **Register-based pixel buffering** to store a 3×3 neighborhood of pixels
* **Sliding window control logic** to manage pixel data for convolution
* Modular architecture with clearly separated control and datapath
* FSM-based control unit for deterministic operation
* Correctly handles **one-cycle read latency** of synchronous memories (e.g., FPGA BRAM)
* Fully synthesizable Verilog design
* Verified using **self-written unit and integration-level testbenches**

---

## Architecture Overview

The accelerator is composed of the following main modules, integrated in a top-level design:

* **control_unit**
  FSM-based controller responsible for sequencing operations, generating memory addresses, and asserting control signals.

* **image_memory**
  A synchronous-read memory module used to model image data access during simulation and integration.

* **single_pixel_conv**
  A purely combinational processing element that performs the **nine multiply–accumulate (MAC)** operations required to compute one output pixel.

* **pixel buffering (pixel_patch)**
  A 3×3 register file used to buffer pixel data between the memory and the processing element, enabling parallel access to neighboring pixels during convolution.

---

## Zynq SoC Integration

* The accelerator is wrapped with an **AXI4-Lite slave interface**
* Integrated with the **Zynq Processing System (PS)**
* Output pixel values are exposed through **memory-mapped registers**
* The design follows an end-to-end **Vivado → Vitis** workflow, including platform creation and BSP configuration

---

## Status

* Hardware accelerator implemented and verified via simulation
* AXI4-Lite integration with Zynq PS completed
* Software-side interaction and UART-based output under development

---

## Tools & Technologies

Language: Verilog
Tools: Vivado, Vitis
Platform: Zynq SoC




