; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S  -mtriple=s390x-unknown-linux -mcpu=z13 -loop-vectorize -dce \
; RUN:   -instcombine -force-vector-width=2  < %s | FileCheck %s
;
; Test that loop vectorizer does not generate vector addresses that must then
; always be extracted.

; Check that the addresses for a scalarized memory access is not extracted
; from a vector register.
define i32 @foo(i32* nocapture %A) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = shl nsw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = or i64 [[TMP1]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP2]]
; CHECK-NEXT:    store i32 4, i32* [[TMP3]], align 4
; CHECK-NEXT:    store i32 4, i32* [[TMP4]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 10000
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret i32 poison
;

entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nsw i64 %indvars.iv, 2
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %0
  store i32 4, i32* %arrayidx, align 4
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 10000
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret i32 poison
}


; Check that a load of address is scalarized.
define i32 @foo1(i32* nocapture noalias %A, i32** nocapture %PtrPtr) {
; CHECK-LABEL: @foo1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = or i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32*, i32** [[PTRPTR:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32*, i32** [[PTRPTR]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32*, i32** [[TMP1]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load i32*, i32** [[TMP2]], align 8
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[TMP4]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <2 x i32> poison, i32 [[TMP5]], i64 0
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <2 x i32> [[TMP7]], i32 [[TMP6]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[TMP9]] to <2 x i32>*
; CHECK-NEXT:    store <2 x i32> [[TMP8]], <2 x i32>* [[TMP10]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], 10000
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret i32 poison
;

entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %ptr = getelementptr inbounds i32*, i32** %PtrPtr, i64 %indvars.iv
  %el = load i32*, i32** %ptr
  %v = load i32, i32* %el
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  store i32 %v, i32* %arrayidx, align 4
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 10000
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret i32 poison
}