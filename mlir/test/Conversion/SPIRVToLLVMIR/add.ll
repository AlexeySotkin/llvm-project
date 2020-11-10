; RUN: mlir-translate --deserialize-spirv %S/Inputs/add.spv -o %t.spv.mlir
; RUN: mlir-opt --convert-spirv-to-llvm %t.spv.mlir -o %t.llvm.mlir
; Need to adjust %t.llvm.mlir, delete redundant top level `module{ }` construct
; RUN: sed -i '1d;$d' %t.llvm.mlir
; RUN: mlir-translate --mlir-to-llvmir %t.llvm.mlir -o %t.ll
; RUN: FileCheck < %t.ll %s

; CHECK: define i32 @add(i32 %0, i32 %1)
; CHECK:  %3 = add i32 %1, %0
; CHECK:  ret i32 %3

; CHECK: define void @spirv_fn_12(i32 %0, i32 %1, i32* %2)
; CHECK:  %4 = call i32 @add(i32 %0, i32 %1)
; CHECK:  store i32 %4, i32* %2, align 4
; CHECK:  ret void

