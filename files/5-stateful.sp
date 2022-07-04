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
  intro Hap.
  rewrite /cond.
  split.

  + intro [H1 H2].
    rewrite /cI in H1.
    intctxt H1 => // Ht Eq _. 
    rewrite /cI /c -Eq dec_enc in H2. 
    by exists k. 

  + intro [k [Ht Eq Hc]].
    rewrite /cI -Eq dec_enc //=. 
    rewrite /cpt => V.
    by apply incr_ne_fail in V. 
Qed.

(* TODO: do not ask to prove both of the following lemmas *)
goal counter_increase (tau1, tau2 : timestamp, i,k : index):
  tau1 < T(i,k) => 
  T(i,k) <= tau2 =>
  cpt(i)@tau1 ~< cpt(i)@tau2.
Proof.
  (* induction tau2 => tau2 IH k1 k2. Eq1 Eq2. *)
  admit.
Qed.

goal counter_increaseR (i : index, tau1, tau2 : timestamp):
  tau1 <= tau2 => 
  exec@tau2 =>
  (Rcpt(i)@tau1 ~~< Rcpt(i)@tau2).
Proof. 
  induction tau2 => tau2 IH Le E.
  case tau2 => //. 

  + intro ?.
    have ?: tau1 = init by auto. 
    by rewrite le_def; right. 

  + intro [j i0 Eq].
    rewrite /Rcpt.
    case (tau1 = tau2) => ?; 1: by rewrite le_def; right.
    case (i = i0) => ? //=; 2: by apply IH.
    rewrite /exec /cond /c in E. 
    apply le_trans _ (Rcpt(i)@pred(tau2)) => //.
    - by apply IH.        
    - by rewrite le_def; left. 
  + intro [j i0 Eq].
    rewrite /Rcpt.
    case (tau1 = tau2) => ?; 1: by rewrite le_def; right.
    case (i = i0) => ? //=; 2: by apply IH.
    rewrite /exec /cond /c in E. 
    apply le_trans _ (Rcpt(i)@pred(tau2)) => //.
    - by apply IH.        
    - by rewrite le_def; right. 

  + intro [j0 k Eq].
    rewrite /Rcpt.
    case (tau1 = tau2) => ?; 1: by rewrite le_def; right.
    by apply IH => //.
Qed.

goal _ (j, i, j1, i1 : index) :
  R(j,i) < R(j1,i1) =>
  exec@R(j,i) =>
  exec@R(j1,i1) =>
  input@R(j,i) = input@R(j1,i1) =>
  i = i1 && j = j1.
Proof.
  intro Hap. 
  intro S1 S2.
  have H1 : cond@R(j,i) by auto.
  have H2 : cond@R(j1,i1) by auto.
  revert H2 H1.
  rewrite !authentication_R //=.
  intro [k [H1 H2 H3]] [k1 [G1 G2 G3]] U.
  rewrite U -G2 /output in H2.

  (* TODO: isolate this in a separated lemma *)
  have ?: i = i1. {
    have V:
      cpt(i)@T(i,k) =
      dec(enc(cpt(i1)@T(i1,k1),n(i1,k1),key(i1)), key(i)) by auto.
    by intctxt V.
  }.
  simpl.
  have Eq: cpt(i)@T(i,k) = cpt(i)@T(i,k1) by auto.

  (* consequence of counter_increase *)
  (* TODO: isolate in a separate lemma *)
  have ?: k = k1. { 
    have A : T(i,k) < T(i,k1) || T(i,k) > T(i,k1) || k = k1 by auto.
    case A => //.
    - have Xa := counter_increase (T(i,k)) (T(i,k1)) i k1. 
      by apply order_strict in Xa. 
    - have Xa := counter_increase (T(i,k1)) (T(i,k)) i k. 
      by apply order_strict in Xa. 
  }.

  have L: forall (t,t' : timestamp), t < t' => t <= pred(t') by auto.
  have O := L _ _ Hap. 
  clear L.
  
  have P : exec@pred(R(j1,i)) by auto.
  have B :=  counter_increaseR i _ _ O P.  
  clear O.
  have A : Rcpt(i)@R(j,i) = cpt(i)@T(i,k) by auto.
  clear S1 S2 U G2. 
  clear H3 G1 H1 Hap.
  rewrite le_def in B. 
  case B.
  + rewrite -A in G3.
    have U := order_trans _ _ _ B G3.
    by apply order_strict in U.
  + rewrite -A B in G3.
    by apply order_strict in G3.
Qed.
