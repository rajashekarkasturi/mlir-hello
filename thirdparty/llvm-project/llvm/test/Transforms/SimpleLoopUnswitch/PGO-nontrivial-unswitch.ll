; NOTE: Assertions have been autogenerated by utils/update_test_checks.py

; RUN: opt < %s -passes='require<profile-summary>,function(loop-mssa(simple-loop-unswitch<nontrivial>))' -S | FileCheck %s
; This test checks for a crash.
; RUN: opt < %s -passes=simple-loop-unswitch -aa-pipeline= -disable-output

declare i32 @a()
declare i32 @b()

define void @f1(i32 %i, i1 %cond, i1 %hot_cond, i1 %cold_cond, i1* %ptr) !prof !0 {
; CHECK-LABEL: @f1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[ENTRY_HOT_LOOP:%.*]]
; CHECK:       entry_hot_loop:
; CHECK-NEXT:    br i1 [[HOT_COND:%.*]], label [[HOT_LOOP_BEGIN_PREHEADER:%.*]], label [[HOT_LOOP_EXIT:%.*]], !prof [[PROF15:![0-9]+]]
; CHECK:       hot_loop_begin.preheader:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[HOT_LOOP_BEGIN_PREHEADER_SPLIT_US:%.*]], label [[HOT_LOOP_BEGIN_PREHEADER_SPLIT:%.*]]
; CHECK:       hot_loop_begin.preheader.split.us:
; CHECK-NEXT:    br label [[HOT_LOOP_BEGIN_US:%.*]]
; CHECK:       hot_loop_begin.us:
; CHECK-NEXT:    br label [[HOT_LOOP_A_US:%.*]]
; CHECK:       hot_loop_a.us:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @a()
; CHECK-NEXT:    br label [[HOT_LOOP_LATCH_US:%.*]]
; CHECK:       hot_loop_latch.us:
; CHECK-NEXT:    [[V1_US:%.*]] = load i1, i1* [[PTR:%.*]], align 1
; CHECK-NEXT:    br i1 [[V1_US]], label [[HOT_LOOP_BEGIN_US]], label [[HOT_LOOP_EXIT_LOOPEXIT_SPLIT_US:%.*]]
; CHECK:       hot_loop_exit.loopexit.split.us:
; CHECK-NEXT:    br label [[HOT_LOOP_EXIT_LOOPEXIT:%.*]]
; CHECK:       hot_loop_begin.preheader.split:
; CHECK-NEXT:    br label [[HOT_LOOP_BEGIN:%.*]]
; CHECK:       hot_loop_begin:
; CHECK-NEXT:    br label [[HOT_LOOP_B:%.*]]
; CHECK:       hot_loop_b:
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @b()
; CHECK-NEXT:    br label [[HOT_LOOP_LATCH:%.*]]
; CHECK:       hot_loop_latch:
; CHECK-NEXT:    [[V1:%.*]] = load i1, i1* [[PTR]], align 1
; CHECK-NEXT:    br i1 [[V1]], label [[HOT_LOOP_BEGIN]], label [[HOT_LOOP_EXIT_LOOPEXIT_SPLIT:%.*]]
; CHECK:       hot_loop_exit.loopexit.split:
; CHECK-NEXT:    br label [[HOT_LOOP_EXIT_LOOPEXIT]]
; CHECK:       hot_loop_exit.loopexit:
; CHECK-NEXT:    br label [[HOT_LOOP_EXIT]]
; CHECK:       hot_loop_exit:
; CHECK-NEXT:    br label [[ENTRY_COLD_LOOP:%.*]]
; CHECK:       entry_cold_loop:
; CHECK-NEXT:    br i1 [[COLD_COND:%.*]], label [[COLD_LOOP_BEGIN_PREHEADER:%.*]], label [[COLD_LOOP_EXIT:%.*]], !prof [[PROF16:![0-9]+]]
; CHECK:       cold_loop_begin.preheader:
; CHECK-NEXT:    br label [[COLD_LOOP_BEGIN:%.*]]
; CHECK:       cold_loop_begin:
; CHECK-NEXT:    br i1 [[COND]], label [[COLD_LOOP_A:%.*]], label [[COLD_LOOP_B:%.*]]
; CHECK:       cold_loop_a:
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @a()
; CHECK-NEXT:    br label [[COLD_LOOP_LATCH:%.*]]
; CHECK:       cold_loop_b:
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @b()
; CHECK-NEXT:    br label [[COLD_LOOP_LATCH]]
; CHECK:       cold_loop_latch:
; CHECK-NEXT:    [[V2:%.*]] = load i1, i1* [[PTR]], align 1
; CHECK-NEXT:    br i1 [[V2]], label [[COLD_LOOP_BEGIN]], label [[COLD_LOOP_EXIT_LOOPEXIT:%.*]]
; CHECK:       cold_loop_exit.loopexit:
; CHECK-NEXT:    br label [[COLD_LOOP_EXIT]]
; CHECK:       cold_loop_exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %entry_hot_loop

entry_hot_loop:
  br i1 %hot_cond, label %hot_loop_begin, label %hot_loop_exit, !prof !15

hot_loop_begin:
  br i1 %cond, label %hot_loop_a, label %hot_loop_b

hot_loop_a:
  call i32 @a()
  br label %hot_loop_latch

hot_loop_b:
  call i32 @b()
  br label %hot_loop_latch

hot_loop_latch:
  %v1 = load i1, i1* %ptr
  br i1 %v1, label %hot_loop_begin, label %hot_loop_exit

hot_loop_exit:
  br label %entry_cold_loop

entry_cold_loop:
  br i1 %cold_cond, label %cold_loop_begin, label %cold_loop_exit, !prof !16

cold_loop_begin:
  br i1 %cond, label %cold_loop_a, label %cold_loop_b

cold_loop_a:
  call i32 @a()
  br label %cold_loop_latch

cold_loop_b:
  call i32 @b()
  br label %cold_loop_latch

cold_loop_latch:
  %v2 = load i1, i1* %ptr
  br i1 %v2, label %cold_loop_begin, label %cold_loop_exit

cold_loop_exit:
  ret void
}

!llvm.module.flags = !{!1}
!0 = !{!"function_entry_count", i64 400}
!1 = !{i32 1, !"ProfileSummary", !2}
!2 = !{!3, !4, !5, !6, !7, !8, !9, !10}
!3 = !{!"ProfileFormat", !"InstrProf"}
!4 = !{!"TotalCount", i64 10000}
!5 = !{!"MaxCount", i64 10}
!6 = !{!"MaxInternalCount", i64 1}
!7 = !{!"MaxFunctionCount", i64 1000}
!8 = !{!"NumCounts", i64 3}
!9 = !{!"NumFunctions", i64 3}
!10 = !{!"DetailedSummary", !11}
!11 = !{!12, !13, !14}
!12 = !{i32 10000, i64 100, i32 1}
!13 = !{i32 999000, i64 100, i32 1}
!14 = !{i32 999999, i64 1, i32 2}
!15 = !{!"branch_weights", i32 100, i32 0}
!16 = !{!"branch_weights", i32 0, i32 100}