; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

define void @widget(i32 %arg) {
; CHECK-LABEL: @widget(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[SWITCH:%.*]] = icmp ult i32 [[ARG:%.*]], 2
; CHECK-NEXT:    br i1 [[SWITCH]], label [[BB2:%.*]], label [[INFLOOP:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    ret void
; CHECK:       infloop:
; CHECK-NEXT:    br label [[INFLOOP]]
;
bb:
  %tmp = icmp eq i32 %arg, 0
  br i1 %tmp, label %bb2, label %bb1

bb1:                                              ; preds = %bb1
  %tmp4 = icmp eq i32 %arg, 1
  br i1 %tmp4, label %bb6, label %bb5

bb5:                                              ; preds = %bb5, %bb5
  switch i32 %arg, label %bb5 [
  i32 0, label %bb9
  ]

bb2:
  ret void

bb6:                                              ; preds = %bb1
  ret void

bb9:                                              ; preds = %bb5
  ret void
}