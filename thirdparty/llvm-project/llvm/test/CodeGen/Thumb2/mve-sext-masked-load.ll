; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp,+fp64 -verify-machineinstrs -o - %s | FileCheck %s
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp,+fp64 -verify-machineinstrs -early-live-intervals -o - %s | FileCheck %s

define arm_aapcs_vfpcc <4 x float> @foo_v4i16(<4 x i16>* nocapture readonly %pSrc, i32 %blockSize, <4 x i16> %a) {
; CHECK-LABEL: foo_v4i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    vpt.s32 lt, q0, zr
; CHECK-NEXT:    vldrht.s32 q0, [r0]
; CHECK-NEXT:    vcvt.f32.s32 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %active.lane.mask = icmp slt <4 x i16> %a, zeroinitializer
  %wide.masked.load = call <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>* %pSrc, i32 2, <4 x i1> %active.lane.mask, <4 x i16> undef)
  %0 = sitofp <4 x i16> %wide.masked.load to <4 x float>
  ret <4 x float> %0
}

define arm_aapcs_vfpcc <8 x half> @foo_v8i8(<8 x i8>* nocapture readonly %pSrc, i32 %blockSize, <8 x i8> %a) {
; CHECK-LABEL: foo_v8i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.s8 q0, q0
; CHECK-NEXT:    vpt.s16 lt, q0, zr
; CHECK-NEXT:    vldrbt.s16 q0, [r0]
; CHECK-NEXT:    vcvt.f16.s16 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %active.lane.mask = icmp slt <8 x i8> %a, zeroinitializer
  %wide.masked.load = call <8 x i8> @llvm.masked.load.v8i8.p0v8i8(<8 x i8>* %pSrc, i32 1, <8 x i1> %active.lane.mask, <8 x i8> undef)
  %0 = sitofp <8 x i8> %wide.masked.load to <8 x half>
  ret <8 x half> %0
}

define arm_aapcs_vfpcc <4 x float> @foo_v4i8(<4 x i8>* nocapture readonly %pSrc, i32 %blockSize, <4 x i8> %a) {
; CHECK-LABEL: foo_v4i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.s8 q0, q0
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    vpt.s32 lt, q0, zr
; CHECK-NEXT:    vldrbt.s32 q0, [r0]
; CHECK-NEXT:    vcvt.f32.s32 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %active.lane.mask = icmp slt <4 x i8> %a, zeroinitializer
  %wide.masked.load = call <4 x i8> @llvm.masked.load.v4i8.p0v4i8(<4 x i8>* %pSrc, i32 1, <4 x i1> %active.lane.mask, <4 x i8> undef)
  %0 = sitofp <4 x i8> %wide.masked.load to <4 x float>
  ret <4 x float> %0
}

define arm_aapcs_vfpcc <4 x double> @foo_v4i32(<4 x i32>* nocapture readonly %pSrc, i32 %blockSize, <4 x i32> %a) {
; CHECK-LABEL: foo_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    vpt.s32 lt, q0, zr
; CHECK-NEXT:    vldrwt.u32 q5, [r0]
; CHECK-NEXT:    vmov.f32 s2, s23
; CHECK-NEXT:    vmov.f32 s16, s22
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    bl __aeabi_l2d
; CHECK-NEXT:    vmov r2, s16
; CHECK-NEXT:    vmov d9, r0, r1
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    mov r1, r3
; CHECK-NEXT:    bl __aeabi_l2d
; CHECK-NEXT:    vmov.f32 s2, s21
; CHECK-NEXT:    vmov d8, r0, r1
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    mov r1, r3
; CHECK-NEXT:    bl __aeabi_l2d
; CHECK-NEXT:    vmov r2, s20
; CHECK-NEXT:    vmov d11, r0, r1
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    mov r1, r3
; CHECK-NEXT:    bl __aeabi_l2d
; CHECK-NEXT:    vmov d10, r0, r1
; CHECK-NEXT:    vmov q1, q4
; CHECK-NEXT:    vmov q0, q5
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    pop {r7, pc}
entry:
  %active.lane.mask = icmp slt <4 x i32> %a, zeroinitializer
  %wide.masked.load = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %pSrc, i32 4, <4 x i1> %active.lane.mask, <4 x i32> undef)
  %0 = sitofp <4 x i32> %wide.masked.load to <4 x double>
  ret <4 x double> %0
}

declare <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>*, i32 immarg, <4 x i1>, <4 x i16>)

declare <8 x i8> @llvm.masked.load.v8i8.p0v8i8(<8 x i8>*, i32 immarg, <8 x i1>, <8 x i8>)

declare <4 x i8> @llvm.masked.load.v4i8.p0v4i8(<4 x i8>*, i32 immarg, <4 x i1>, <4 x i8>)

declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32 immarg, <4 x i1>, <4 x i32>)