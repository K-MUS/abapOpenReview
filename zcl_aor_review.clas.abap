class ZCL_AOR_REVIEW definition
  public
  final
  create public .

public section.
*"* public components of class ZCL_AOR_REVIEW
*"* do not include other source files here!!!

  types:
    TY_REVIEW_TT type table of zaor_review with default key .

  constants C_STATUS_OPEN type CHAR1 value 'O'. "#EC NOTEXT
  constants C_STATUS_CLOSED type CHAR1 value 'C'. "#EC NOTEXT

  class-methods NEW
    importing
      !IV_TRKORR type TRKORR .
  class-methods LIST
    returning
      value(RT_DATA) type TY_REVIEW_TT .
  class-methods ADD_COMMENT
    importing
      !IV_TRKORR type TRKORR
      !IV_TEXT type STRING .
protected section.
*"* protected components of class ZCL_AOR_REVIEW
*"* do not include other source files here!!!
private section.
*"* private components of class ZCL_AOR_REVIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCL_AOR_REVIEW IMPLEMENTATION.


METHOD add_comment.

  DATA: ls_comment TYPE zaor_comment.


* todo: validate that review is still open

  ls_comment-trkorr = iv_trkorr.
  ls_comment-topic  = 'todo'.
  ls_comment-id     = ''.
  ls_comment-text   = iv_text.
  ls_comment-bname  = sy-uname.

  INSERT zaor_comment FROM ls_comment.


ENDMETHOD.


METHOD list.

  SELECT * FROM zaor_review INTO TABLE rt_data.

ENDMETHOD.


METHOD new.

  DATA: ls_review TYPE zaor_review,
        lt_open TYPE zcl_aor_transport=>ty_transport_tt.


* validate input
  lt_open = zcl_aor_transport=>list_open( lcl_range=>trkorr( iv_trkorr ) ).
  IF lines( lt_open ) <> 1.
    BREAK-POINT.
  ENDIF.

  CLEAR ls_review.
  ls_review-trkorr = iv_trkorr.
  ls_review-status = c_status_open.
  INSERT zaor_review FROM ls_review.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

ENDMETHOD.
ENDCLASS.