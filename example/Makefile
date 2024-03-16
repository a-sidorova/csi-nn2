
c906_m1_f16:
	riscv64-unknown-linux-gnu-gcc c906_mobilenetv1_f16.c -o c906_mobilenetv1_f16.elf -I../include ../install_nn2/lib/libshl_c906.a -lm -static

c920_conv:
	riscv64-unknown-linux-gnu-gcc c920_conv2d_f32.c -o c920_conv2d_f32.elf -I../install_nn2/c920/include/shl_public ../install_nn2/c920/lib/libshl_c920.a -lm -static -fopenmp

rvv_conv:
	riscv64-unknown-linux-gnu-gcc rvv_conv2d_f32.c -o rvv_conv2d_f32.elf -I../install_nn2/rvv/include/shl_public ../install_nn2/rvv/lib/libshl_rvv.a -lm -static

clean:
	rm -rf *.elf
