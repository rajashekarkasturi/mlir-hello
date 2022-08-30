; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+experimental-zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+experimental-zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x half> @floor_nxv1f16(<vscale x 1 x half> %x) {
; CHECK-LABEL: floor_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI0_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, mu
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v9, v9, ft0
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vfcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI0_1)
; CHECK-NEXT:    flh ft0, %lo(.LCPI0_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v11, v10, v0.t
; CHECK-NEXT:    vmv1r.v v10, v9
; CHECK-NEXT:    vmflt.vv v10, v8, v11, v0.t
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfsub.vf v11, v11, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vfsgnj.vv v8, v11, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x half> @llvm.floor.nxv1f16(<vscale x 1 x half> %x)
  ret <vscale x 1 x half> %a
}
declare <vscale x 1 x half> @llvm.floor.nxv1f16(<vscale x 1 x half>)

define <vscale x 2 x half> @floor_nxv2f16(<vscale x 2 x half> %x) {
; CHECK-LABEL: floor_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI1_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI1_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, mu
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v9, v9, ft0
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vfcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI1_1)
; CHECK-NEXT:    flh ft0, %lo(.LCPI1_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v11, v10, v0.t
; CHECK-NEXT:    vmv1r.v v10, v9
; CHECK-NEXT:    vmflt.vv v10, v8, v11, v0.t
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfsub.vf v11, v11, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vfsgnj.vv v8, v11, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x half> @llvm.floor.nxv2f16(<vscale x 2 x half> %x)
  ret <vscale x 2 x half> %a
}
declare <vscale x 2 x half> @llvm.floor.nxv2f16(<vscale x 2 x half>)

define <vscale x 4 x half> @floor_nxv4f16(<vscale x 4 x half> %x) {
; CHECK-LABEL: floor_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI2_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI2_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, mu
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v9, v9, ft0
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    vfcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI2_1)
; CHECK-NEXT:    flh ft0, %lo(.LCPI2_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v11, v10, v0.t
; CHECK-NEXT:    vmv.v.v v10, v9
; CHECK-NEXT:    vmflt.vv v10, v8, v11, v0.t
; CHECK-NEXT:    vmv.v.v v0, v10
; CHECK-NEXT:    vfsub.vf v11, v11, ft0, v0.t
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    vfsgnj.vv v8, v11, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x half> @llvm.floor.nxv4f16(<vscale x 4 x half> %x)
  ret <vscale x 4 x half> %a
}
declare <vscale x 4 x half> @llvm.floor.nxv4f16(<vscale x 4 x half>)

define <vscale x 8 x half> @floor_nxv8f16(<vscale x 8 x half> %x) {
; CHECK-LABEL: floor_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI3_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI3_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, mu
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v10, v12, ft0
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfcvt.rtz.x.f.v v12, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI3_1)
; CHECK-NEXT:    flh ft0, %lo(.LCPI3_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vmv1r.v v11, v10
; CHECK-NEXT:    vmflt.vv v11, v8, v12, v0.t
; CHECK-NEXT:    vmv1r.v v0, v11
; CHECK-NEXT:    vfsub.vf v12, v12, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x half> @llvm.floor.nxv8f16(<vscale x 8 x half> %x)
  ret <vscale x 8 x half> %a
}
declare <vscale x 8 x half> @llvm.floor.nxv8f16(<vscale x 8 x half>)

define <vscale x 16 x half> @floor_nxv16f16(<vscale x 16 x half> %x) {
; CHECK-LABEL: floor_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI4_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI4_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, mu
; CHECK-NEXT:    vfabs.v v16, v8
; CHECK-NEXT:    vmflt.vf v12, v16, ft0
; CHECK-NEXT:    vmv1r.v v0, v12
; CHECK-NEXT:    vfcvt.rtz.x.f.v v16, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI4_1)
; CHECK-NEXT:    flh ft0, %lo(.LCPI4_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; CHECK-NEXT:    vmv1r.v v13, v12
; CHECK-NEXT:    vmflt.vv v13, v8, v16, v0.t
; CHECK-NEXT:    vmv1r.v v0, v13
; CHECK-NEXT:    vfsub.vf v16, v16, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v12
; CHECK-NEXT:    vfsgnj.vv v8, v16, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 16 x half> @llvm.floor.nxv16f16(<vscale x 16 x half> %x)
  ret <vscale x 16 x half> %a
}
declare <vscale x 16 x half> @llvm.floor.nxv16f16(<vscale x 16 x half>)

define <vscale x 32 x half> @floor_nxv32f16(<vscale x 32 x half> %x) {
; CHECK-LABEL: floor_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI5_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI5_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, mu
; CHECK-NEXT:    vfabs.v v24, v8
; CHECK-NEXT:    vmflt.vf v16, v24, ft0
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfcvt.rtz.x.f.v v24, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI5_1)
; CHECK-NEXT:    flh ft0, %lo(.LCPI5_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v24, v24, v0.t
; CHECK-NEXT:    vmv1r.v v17, v16
; CHECK-NEXT:    vmflt.vv v17, v8, v24, v0.t
; CHECK-NEXT:    vmv1r.v v0, v17
; CHECK-NEXT:    vfsub.vf v24, v24, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfsgnj.vv v8, v24, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 32 x half> @llvm.floor.nxv32f16(<vscale x 32 x half> %x)
  ret <vscale x 32 x half> %a
}
declare <vscale x 32 x half> @llvm.floor.nxv32f16(<vscale x 32 x half>)

define <vscale x 1 x float> @floor_nxv1f32(<vscale x 1 x float> %x) {
; CHECK-LABEL: floor_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI6_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI6_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v9, v9, ft0
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vfcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI6_1)
; CHECK-NEXT:    flw ft0, %lo(.LCPI6_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v11, v10, v0.t
; CHECK-NEXT:    vmv1r.v v10, v9
; CHECK-NEXT:    vmflt.vv v10, v8, v11, v0.t
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfsub.vf v11, v11, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vfsgnj.vv v8, v11, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x float> @llvm.floor.nxv1f32(<vscale x 1 x float> %x)
  ret <vscale x 1 x float> %a
}
declare <vscale x 1 x float> @llvm.floor.nxv1f32(<vscale x 1 x float>)

define <vscale x 2 x float> @floor_nxv2f32(<vscale x 2 x float> %x) {
; CHECK-LABEL: floor_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI7_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI7_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, mu
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v9, v9, ft0
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    vfcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI7_1)
; CHECK-NEXT:    flw ft0, %lo(.LCPI7_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v11, v10, v0.t
; CHECK-NEXT:    vmv.v.v v10, v9
; CHECK-NEXT:    vmflt.vv v10, v8, v11, v0.t
; CHECK-NEXT:    vmv.v.v v0, v10
; CHECK-NEXT:    vfsub.vf v11, v11, ft0, v0.t
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    vfsgnj.vv v8, v11, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x float> @llvm.floor.nxv2f32(<vscale x 2 x float> %x)
  ret <vscale x 2 x float> %a
}
declare <vscale x 2 x float> @llvm.floor.nxv2f32(<vscale x 2 x float>)

define <vscale x 4 x float> @floor_nxv4f32(<vscale x 4 x float> %x) {
; CHECK-LABEL: floor_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI8_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI8_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, mu
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v10, v12, ft0
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfcvt.rtz.x.f.v v12, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI8_1)
; CHECK-NEXT:    flw ft0, %lo(.LCPI8_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vmv1r.v v11, v10
; CHECK-NEXT:    vmflt.vv v11, v8, v12, v0.t
; CHECK-NEXT:    vmv1r.v v0, v11
; CHECK-NEXT:    vfsub.vf v12, v12, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x float> @llvm.floor.nxv4f32(<vscale x 4 x float> %x)
  ret <vscale x 4 x float> %a
}
declare <vscale x 4 x float> @llvm.floor.nxv4f32(<vscale x 4 x float>)

define <vscale x 8 x float> @floor_nxv8f32(<vscale x 8 x float> %x) {
; CHECK-LABEL: floor_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI9_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI9_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, mu
; CHECK-NEXT:    vfabs.v v16, v8
; CHECK-NEXT:    vmflt.vf v12, v16, ft0
; CHECK-NEXT:    vmv1r.v v0, v12
; CHECK-NEXT:    vfcvt.rtz.x.f.v v16, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI9_1)
; CHECK-NEXT:    flw ft0, %lo(.LCPI9_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; CHECK-NEXT:    vmv1r.v v13, v12
; CHECK-NEXT:    vmflt.vv v13, v8, v16, v0.t
; CHECK-NEXT:    vmv1r.v v0, v13
; CHECK-NEXT:    vfsub.vf v16, v16, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v12
; CHECK-NEXT:    vfsgnj.vv v8, v16, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x float> @llvm.floor.nxv8f32(<vscale x 8 x float> %x)
  ret <vscale x 8 x float> %a
}
declare <vscale x 8 x float> @llvm.floor.nxv8f32(<vscale x 8 x float>)

define <vscale x 16 x float> @floor_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: floor_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI10_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI10_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, mu
; CHECK-NEXT:    vfabs.v v24, v8
; CHECK-NEXT:    vmflt.vf v16, v24, ft0
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfcvt.rtz.x.f.v v24, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI10_1)
; CHECK-NEXT:    flw ft0, %lo(.LCPI10_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v24, v24, v0.t
; CHECK-NEXT:    vmv1r.v v17, v16
; CHECK-NEXT:    vmflt.vv v17, v8, v24, v0.t
; CHECK-NEXT:    vmv1r.v v0, v17
; CHECK-NEXT:    vfsub.vf v24, v24, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfsgnj.vv v8, v24, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 16 x float> @llvm.floor.nxv16f32(<vscale x 16 x float> %x)
  ret <vscale x 16 x float> %a
}
declare <vscale x 16 x float> @llvm.floor.nxv16f32(<vscale x 16 x float>)

define <vscale x 1 x double> @floor_nxv1f64(<vscale x 1 x double> %x) {
; CHECK-LABEL: floor_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI11_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI11_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, mu
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v9, v9, ft0
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    vfcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI11_1)
; CHECK-NEXT:    fld ft0, %lo(.LCPI11_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v11, v10, v0.t
; CHECK-NEXT:    vmv.v.v v10, v9
; CHECK-NEXT:    vmflt.vv v10, v8, v11, v0.t
; CHECK-NEXT:    vmv.v.v v0, v10
; CHECK-NEXT:    vfsub.vf v11, v11, ft0, v0.t
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    vfsgnj.vv v8, v11, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x double> @llvm.floor.nxv1f64(<vscale x 1 x double> %x)
  ret <vscale x 1 x double> %a
}
declare <vscale x 1 x double> @llvm.floor.nxv1f64(<vscale x 1 x double>)

define <vscale x 2 x double> @floor_nxv2f64(<vscale x 2 x double> %x) {
; CHECK-LABEL: floor_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI12_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI12_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, mu
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v10, v12, ft0
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfcvt.rtz.x.f.v v12, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI12_1)
; CHECK-NEXT:    fld ft0, %lo(.LCPI12_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vmv1r.v v11, v10
; CHECK-NEXT:    vmflt.vv v11, v8, v12, v0.t
; CHECK-NEXT:    vmv1r.v v0, v11
; CHECK-NEXT:    vfsub.vf v12, v12, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x double> @llvm.floor.nxv2f64(<vscale x 2 x double> %x)
  ret <vscale x 2 x double> %a
}
declare <vscale x 2 x double> @llvm.floor.nxv2f64(<vscale x 2 x double>)

define <vscale x 4 x double> @floor_nxv4f64(<vscale x 4 x double> %x) {
; CHECK-LABEL: floor_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI13_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI13_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, mu
; CHECK-NEXT:    vfabs.v v16, v8
; CHECK-NEXT:    vmflt.vf v12, v16, ft0
; CHECK-NEXT:    vmv1r.v v0, v12
; CHECK-NEXT:    vfcvt.rtz.x.f.v v16, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI13_1)
; CHECK-NEXT:    fld ft0, %lo(.LCPI13_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; CHECK-NEXT:    vmv1r.v v13, v12
; CHECK-NEXT:    vmflt.vv v13, v8, v16, v0.t
; CHECK-NEXT:    vmv1r.v v0, v13
; CHECK-NEXT:    vfsub.vf v16, v16, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v12
; CHECK-NEXT:    vfsgnj.vv v8, v16, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x double> @llvm.floor.nxv4f64(<vscale x 4 x double> %x)
  ret <vscale x 4 x double> %a
}
declare <vscale x 4 x double> @llvm.floor.nxv4f64(<vscale x 4 x double>)

define <vscale x 8 x double> @floor_nxv8f64(<vscale x 8 x double> %x) {
; CHECK-LABEL: floor_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI14_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI14_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, mu
; CHECK-NEXT:    vfabs.v v24, v8
; CHECK-NEXT:    vmflt.vf v16, v24, ft0
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfcvt.rtz.x.f.v v24, v8, v0.t
; CHECK-NEXT:    lui a0, %hi(.LCPI14_1)
; CHECK-NEXT:    fld ft0, %lo(.LCPI14_1)(a0)
; CHECK-NEXT:    vfcvt.f.x.v v24, v24, v0.t
; CHECK-NEXT:    vmv1r.v v17, v16
; CHECK-NEXT:    vmflt.vv v17, v8, v24, v0.t
; CHECK-NEXT:    vmv1r.v v0, v17
; CHECK-NEXT:    vfsub.vf v24, v24, ft0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfsgnj.vv v8, v24, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x double> @llvm.floor.nxv8f64(<vscale x 8 x double> %x)
  ret <vscale x 8 x double> %a
}
declare <vscale x 8 x double> @llvm.floor.nxv8f64(<vscale x 8 x double>)