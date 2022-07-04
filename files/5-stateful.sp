(*******************************************************************************
# A Simple Stateful Protocol
*******************************************************************************)

include Basic.

(* ----------------------------------------------------------------- *)
(** ## declarations *)

senc enc, dec.

abstract ok : message
abstract ko : message

(* `key(i)` is the key of the tag with identity `i` *)
name key : index -> message

(* ----------------------------------------------------------------- *)

(* stateful counter stored by the tags *)
mutable cpt (i : index) : message = zero.

(* stateful counter stored by the reader *)
mutable Rcpt (i : index) : message = zero.

(* ----------------------------------------------------------------- *)
(* operators over counter values *)

abstract incr : message -> message.
abstract (~<) : message -> message -> boolean.

(* abstract encode : message -> message. *)

(* ----------------------------------------------------------------- *)
(* channel for tag messages *)
channel cT

(* channel for reader messages *)
channel cR.

(* ----------------------------------------------------------------- *)
(** ## axioms *)

axiom [any] dec_enc (x, y, z : message) : dec(enc(x,y,z),z) = x.

axiom [any] order_trans (n1,n2,n3:message):
  n1 ~< n2 => n2 ~< n3 => n1 ~< n3.

axiom [any] order_strict (n1,n2:message):
  n1 = n2 => n1 ~< n2 => false. 

axiom [any] order_incr (n1,n2:message):
  n1 = n2 => n1 ~< incr(n2).

(* ----------------------------------------------------------------- *)
(** ## ordering bis *)

(* we introduce the lesser-or-equal version of `~<` *)
abstract (~~<) : message -> message -> boolean.

axiom [any] le_def (x,y : message) : x ~~< y <=> (x ~< y || x = y).

axiom [any] le_trans (n1,n2,n3:message):
  n1 ~~< n2 => n2 ~~< n3 => n1 ~~< n3.

(* ----------------------------------------------------------------- *)
(* we assume that the constant `fail` is different from `zero` *)
axiom [any] zero_ne_fail : zero <> fail.

(* similarly, we assume that increasing a value `x` cannot yield `fail` *)
axiom [any] incr_ne_fail (x : message): incr(x) = fail => false.

(* ----------------------------------------------------------------- *)
(** ## Processes *)

(* session number `k` of the RFID tag with identity `i` *)
process tag(i : index, k : index) =
  cpt(i) := incr(cpt(i));
  new n;
  T: out(cT, enc(cpt(i), n, key(i))).

(* session number `j` of the reader R trying to authenticate tag `i` *)
process reader(j : index, i : index) =
  in(cT,x);
  let cI = dec(x, key(i)) in
  let c = Rcpt(i) in
  if cI <> fail && c ~< cI then
    Rcpt(i) := cI;
    R: out(cR, ok)
  else R1: out(cR, ko).

system (
  (!_j !_i reader(j,i) ) | 
  (!_i !_k    tag(i,k) ) 
).

(* ----------------------------------------------------------------- *)
(** ## security proofs *)

goal authentication_R (j, i : index) :
  happens(R(j,i)) =>
  cond@R(j,i) <=>
  exists (k : index),
    T(i,k) < R(j,i) &&
    output@T(i,k) = input@R(j,i) &&
    Rcpt(i)@pred(R(j,i)) ~< cpt(i)@T(i,k).
Proof.
  admit. (* TODO *)
Qed.

goal counter_increase (tau1, tau2 : timestamp, i,k : index):
  tau1 < T(i,k) => 
  T(i,k) <= tau2 =>
  cpt(i)@tau1 ~< cpt(i)@tau2.
Proof.
  admit. (* TODO *)
Qed.

goal counter_increaseR (i : index, tau1, tau2 : timestamp):
  tau1 <= tau2 => 
  exec@tau2 =>
  (Rcpt(i)@tau1 ~~< Rcpt(i)@tau2).
Proof. 
  admit. (* TODO *)
Qed.

goal _ (j, i, j1, i1 : index) :
  R(j,i) < R(j1,i1) =>
  exec@R(j,i) =>
  exec@R(j1,i1) =>
  input@R(j,i) = input@R(j1,i1) =>
  i = i1 && j = j1.
Proof.
  admit. (* TODO *)
Qed.
