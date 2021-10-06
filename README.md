# Gaussian LPF
More control over the Low-Pass Filter than default MATLAB function

*written in MATLAB R2017b*

- Simply run the **"LPF.m"** file. **"conv2fft.m"** is a subroutine of **"LPF.m"** file.
- To change the Image you want to filter, simply edit the "Line 4" in **"LPF.m"** file.
- The new input Image & **"conv2fft.m"** must be in the same directory as of **"LPF.m"** file.
- By default, the code takes "bsec.jpg" as example, processes it, then saves it as "comp.jpg" file.
- Without any filtering, MATLAB uses its own compression. So, don't be overwhelmed here. Further filtering makes the input Image more compressed.
