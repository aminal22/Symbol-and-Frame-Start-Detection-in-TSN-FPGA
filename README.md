### Symbol and Frame Start Detection in TSN FPGA

#### Overview:
This project aims to detect the start of symbols and frames in Time-Sensitive Networking (TSN) using FPGA. The detection is achieved by correlating the received signal with predefined symbols and guards.

#### Detection Method:
- A symbol consists of two identical halves, making it easy to detect the start by correlating the first and second halves of the symbol.
- A guard is appended at the end of each symbol to facilitate detection. The guard ensures a strong correlation throughout its duration.

#### System Specifications:
- Number of samples per symbol: `gFFT_length = 256`
- Length of guard: `gGard_length = 32`

#### Architecture:
The architecture is divided into two blocks:
1. Symbol Start Detection Block: Performs correlation between the first and second halves of the symbol to detect its start.
2. Frame Start Detection Block: Detects the start of different symbols within a frame by copying a guard at the end of each symbol.



![trame](https://github.com/aminal22/Symbol-and-Frame-Start-Detection-in-TSN-FPGA/assets/114859285/1ba91a1d-bcd7-4326-963d-7359d5bc21c0)





#### Implementation:
- The architecture can be implemented in a single VHDL file or divided into two VHDL files.
- Utilize Altera's tools to create two shift registers of lengths `gFFT_length/2` and `gGard_length`, named `shiftregister1` and `shiftregister2` respectively.
- The VHDL file should illustrate the different components of the architecture, respecting their names and signal names as indicated in the figure.



#### Usage:
1. Compile the VHDL code using Altera's tools.
2. Upload the compiled design to the FPGA board.
3. Provide the input signal to the FPGA for symbol and frame detection.

#### Additional Notes:
- TSN FPGA projects are crucial for real-time networking applications requiring precise timing and synchronization.
- This project focuses on the detection aspect, which is fundamental for TSN communication.

#### License:
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
