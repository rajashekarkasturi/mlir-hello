; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -aa-pipeline=basic-aa,globals-aa -passes='require<globals-aa>,gvn' -S < %s | FileCheck %s

; Make sure we do not hoist the load before the intrinsic, unknown function, or
; optnone function except if we know the unknown function is nosync and nocallback.

@G1 = internal global i32 undef
@G2 = internal global i32 undef
@G3 = internal global i32 undef
@G4 = internal global i32 undef

define void @test_barrier(i1 %c) {
; CHECK-LABEL: define {{[^@]+}}@test_barrier
; CHECK-SAME: (i1 [[C:%.*]]) {
; CHECK-NEXT:    br i1 [[C]], label [[INIT:%.*]], label [[CHECK:%.*]]
; CHECK:       init:
; CHECK-NEXT:    store i32 0, ptr @G1, align 4
; CHECK-NEXT:    br label [[CHECK]]
; CHECK:       check:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr @G1, align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[V]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret void
;
  br i1 %c, label %init, label %check
init:
  store i32 0, ptr @G1
  br label %check
check:
  call void @llvm.amdgcn.s.barrier()
  %v = load i32, ptr @G1
  %cmp = icmp eq i32 %v, 0
  call void @llvm.assume(i1 %cmp)
  ret void
}

define void @test_unknown(i1 %c) {
; CHECK-LABEL: define {{[^@]+}}@test_unknown
; CHECK-SAME: (i1 [[C:%.*]]) {
; CHECK-NEXT:    br i1 [[C]], label [[INIT:%.*]], label [[CHECK:%.*]]
; CHECK:       init:
; CHECK-NEXT:    store i32 0, ptr @G2, align 4
; CHECK-NEXT:    br label [[CHECK]]
; CHECK:       check:
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr @G2, align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[V]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret void
;
  br i1 %c, label %init, label %check
init:
  store i32 0, ptr @G2
  br label %check
check:
  call void @unknown()
  %v = load i32, ptr @G2
  %cmp = icmp eq i32 %v, 0
  call void @llvm.assume(i1 %cmp)
  ret void
}

define void @test_optnone(i1 %c) {
; CHECK-LABEL: define {{[^@]+}}@test_optnone
; CHECK-SAME: (i1 [[C:%.*]]) {
; CHECK-NEXT:    br i1 [[C]], label [[INIT:%.*]], label [[CHECK:%.*]]
; CHECK:       init:
; CHECK-NEXT:    store i32 0, ptr @G3, align 4
; CHECK-NEXT:    br label [[CHECK]]
; CHECK:       check:
; CHECK-NEXT:    call void @optnone()
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr @G3, align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[V]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret void
;
  br i1 %c, label %init, label %check
init:
  store i32 0, ptr @G3
  br label %check
check:
  call void @optnone()
  %v = load i32, ptr @G3
  %cmp = icmp eq i32 %v, 0
  call void @llvm.assume(i1 %cmp)
  ret void
}

define void @optnone() optnone nosync nocallback noinline {
; CHECK: Function Attrs: nocallback noinline nosync optnone
; CHECK-LABEL: define {{[^@]+}}@optnone
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

; Here hoisting is legal and we use it to verify it will happen.
define void @test_unknown_annotated(i1 %c) {
; CHECK-LABEL: define {{[^@]+}}@test_unknown_annotated
; CHECK-SAME: (i1 [[C:%.*]]) {
; CHECK-NEXT:    br i1 [[C]], label [[INIT:%.*]], label [[DOTCHECK_CRIT_EDGE:%.*]]
; CHECK:       .check_crit_edge:
; CHECK-NEXT:    [[V_PRE:%.*]] = load i32, ptr @G4, align 4
; CHECK-NEXT:    br label [[CHECK:%.*]]
; CHECK:       init:
; CHECK-NEXT:    store i32 0, ptr @G4, align 4
; CHECK-NEXT:    br label [[CHECK]]
; CHECK:       check:
; CHECK-NEXT:    [[V:%.*]] = phi i32 [ [[V_PRE]], [[DOTCHECK_CRIT_EDGE]] ], [ 0, [[INIT]] ]
; CHECK-NEXT:    call void @unknown_nosync_nocallback()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[V]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret void
;
  br i1 %c, label %init, label %check
init:
  store i32 0, ptr @G4
  br label %check
check:
  call void @unknown_nosync_nocallback()
  %v = load i32, ptr @G4
  %cmp = icmp eq i32 %v, 0
  call void @llvm.assume(i1 %cmp)
  ret void
}

declare void @unknown()
declare void @unknown_nosync_nocallback() nosync nocallback
declare void @llvm.amdgcn.s.barrier()
declare void @llvm.assume(i1 noundef)
