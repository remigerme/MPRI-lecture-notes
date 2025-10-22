#import "../utils.typ": *
#import "utils.typ": *
#show: notes.with(title: "CODES 4 - Duality")

Endow $FF_q^n$ with the symmetric bilinear form:
$
  scal(dot, dot): cases(delim: #none, FF_q^n times FF_q^n -> FF_q^n, (x, y) mapsto lsum_(i=1)^n x_i y_i)
$

#def(title: "Dual code")[
  For $cC seq FF_q^n$ a code, we define its _dual code_ $cC^bot$ as $ cC^bot := {x in FF_q^n | forall c in cC, scal(x, c) = 0} $
]

= Properties

#prop()[
  Let $cC seq FF_q^n$ be a code with generator matrix $G$ and parity check matrix $H$.

  Then $G$ is a parity check matrix of $cC^bot$ and $H$ is a generator matrix of $cC^bot$.
]

*Proof (exercise).* \
Hint: take note that $G dot H^T = 0$: rows of $G$ are orthogonal to rows of $H$.

#prop()[
  1. $dim cC^bot = n - dim cC$
  2. $(cC^bot)^bot = cC$ (immediate from prop. 1)
  3. $(cC + cal(D))^bot = cC^bot inter cal(D)^bot$
  4. $(cC inter cal(D))^bot = cC^bot + cal(D)^bot$
]

#emoji.warning In real Euclidean spaces, if $cC seq RR^n$ then: $RR^n = cC plus.circle cC^bot$. *This is not true in $FF_q^n$ with $scal(dot, dot)$.*

#ex()[
  $cC seq FF_2^n$ with generator matrix $G = mat(1, 0, 1, 0; 0, 1, 0, 1)$.

  Then $cC = cC^bot$.
]

*Remark.* The dual of the *repetition code* is the *parity code*.

= Metric relation: the McWilliams theorem

*Question.* Is there a relation between the minimum distances of $cC$ and $cC^bot$? \
No.

*Explanation.* Minimum distance is not informative enough for this problem.

#def(title: "Weight enumerator")[
  Let $cC seq FF_q^n$ a code, its _weight enumerating polynomial_ $P_cC in ZZ[X, Y]$ is defined as: $ P_cC(x, y) := sum_(i=0)^n |{c in C | w(c) = i}|x^i y^(n-i) $
]

#th(title: "McWilliams")[
  Let $cC seq FF_2^n$ a code. Then: $ P_(cC^bot) (x, y) = 1 / (|cC|) P(y -x, y + x) $
]

The proof rests of the following lemma:

#lemma()[
  Let $f: FF_2^n -> CC$ and denote $ hat(f): cases(FF_2^n -> CC, v mapsto lsum_(u in FF_2^n) (-1)^scal(u, v) f(u)) $
  Let $cC seq FF_2^n$ be a code.

  Then: $ forall f: FF_2^n -> CC, sum_(u in cC^bot) f(u) = 1 / (|cC|) sum_(v in cC) hat(f)(v) $
]

*Proof.*
$
  (star) quad sum_(v in cC) hat(f)(v) & = sum_(v in cC)sum_(u in FF_2^n) (-1)^scal(u, v) f(u) \
                                      & = sum_(u in FF_2^n) f(u) sum_(v in cC) (-1)^scal(u, v)
$
Fact: $ sum_(v in cC) (-1)^scal(u, v) = cases(|cC| "if" u in cC^bot, 0 "otherwise") $

- If $u in cC^bot, sum_(v in cC) (-1)^0 = |cC|$
- If $u in.not cC^bot$, then the map: $phi_u : cases(cC -> FF_2, v mapsto scal(u, v))$ is a nonzero linear form: $dim ker phi_u = dim cC - 1$. Thus:
  - $scal(u, v) = 0 space 2^(k-1)$ times
  - $scal(u, v) = 1 space 2^k - 2^(k-1) = 2^(k-1)$ times

Back to $(star)$: $ sum_(v in cC) hat(f)(v) = sum_(u in cC^bot) f(u) |C| quad qed $

*Proof of McWilliams theorem.* \
We will prove $P_(cC^bot) (x,y) = 1/ (|C|) P_cC (y-x, y+x)$ for any $(x, y) in CC^* times CC^*$.

Algebraic identities prolongation theorem says two bivariate polynomials coinciding on a product of two infinite sets are equal.

Fix $x, y in CC^* times CC^*$ and take: $ f: cases(FF_2^n -> CC, u mapsto x^(w(u)) y^(n - w(u))) $

Note that $P_cC(x, y) = lsum_(u in cC)f(u)$.

$
  hat(f)(v) & = sum_(u in FF_2^n)(-1)^scal(u, v)x^w(u) y^(n-w(u)) \
  & = sum_((u_1, ..., u_n) in FF_2^n) (-1)^(u_1v_1) ... (-1)^(u_n v_n) x^(u_1)...x^(u_n) y^(1-u_1) ... y^(1-u_n) \
  &= sum_((u_1, ..., u_n) in FF_2^n) product_(i=1)^n (-1)^(u_i v_i) x^(u_i) y^(1-u_i) \
  &= product_(i=1)^n (sum_(t in FF_2) (-1)^(t v_i) x^t y^(1-t)) \
  &= product_(i=1)^n (y + (-1)^(v_i)x) \
  italic("i.e.") hat(f)(v) &= (y+x)^(n-w(v))(y-x)^w(v) \
$

Now, we can finish the proof using the lemma (skipped on my notes).
