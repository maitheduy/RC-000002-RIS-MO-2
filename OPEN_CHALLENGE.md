# Open Challenge: Two-Map Contractive IFS for Prescribed Simplex Partitions

**Proposed by S.S. Duymt. Status: research challenge; not covered by the Lean verification of the four-map seed.**

### A. An arbitrary triangle split by a prescribed cevian

Let $A,B,C\in\mathbb R^2$ be noncollinear, let $T=\mathrm{conv}\{A,B,C\}$, and choose an arbitrary point $M\in\mathrm{relint}[A,C]$. The ray $BM$ cuts the solid triangle along the segment $[B,M]$ into

$$
T_1=\mathrm{conv}\{A,B,M\},\qquad
T_2=\mathrm{conv}\{M,B,C\}.
$$

**Can two affine maps $g_1,g_2:\mathbb R^2\to\mathbb R^2$ be constructed, both strict contractions in the standard Euclidean metric, such that**

$$
g_1(T)=T_1,\qquad g_2(T)=T_2?
$$

These requirements imply the exact covering equation

$$
T=g_1(T)\cup g_2(T),\qquad
\mathrm{int}g_1(T)\cap\mathrm{int}g_2(T)=\varnothing,
$$

and would make $T$ the unique attractor of a two-map contractive IFS. The requirement concerns the **prescribed** two pieces, not merely any two-map representation of $T$.

Determine whether this construction is possible for **every** nondegenerate triangle and **every** interior choice of $M$. If the universal assertion fails, give explicit counterexamples and characterize the admissible triangles, cut ratios, and ordered vertex assignments. A construction must exhibit the two matrices and translations, prove Euclidean contractivity, and verify both image equalities. Endpoints $M=A$ or $M=C$ are excluded so that both pieces are nondegenerate.

### B. A tetrahedron cut by a plane in three dimensions

Let $S=\mathrm{conv}\{A,B,C,D\}\subset\mathbb R^3$ be a nondegenerate solid tetrahedron. Let a plane $H$ meet its interior and let $H^+,H^-$ be the two closed half-spaces bounded by $H$. Write

$$
S_1=S\cap H^+,\qquad S_2=S\cap H^-.
$$

Seek **exactly two** strict contractions $g_1,g_2$ with $g_i(S)=S_i$, so that the two prescribed pieces tile $S$ and $S$ is the IFS attractor. First determine the feasibility of this requirement in the affine class; do not assume that every plane cut admits such a representation.

**Geometric qualification.** An arbitrary plane cut need not yield two tetrahedra. An affine image of a tetrahedron has at most four extreme points, so a full-dimensional cut piece with more than four extreme points cannot be the image of that tetrahedron under a single affine map. Thus the unrestricted assertion for all plane cuts is already false in the affine class. The challenge is to classify the admissible cuts and establish contractivity, or to state and study a genuinely different nonlinear version explicitly.

A natural tetrahedral subproblem is obtained by choosing $M\in\mathrm{relint}[C,D]$ and taking $H$ through the edge $[A,B]$ and $M$. The two pieces are

$$
S_1=\mathrm{conv}\{A,B,C,M\},\qquad
S_2=\mathrm{conv}\{A,B,M,D\}.
$$

For arbitrary nondegenerate $S$ and arbitrary such $M$, decide when these two tetrahedra can be realized as the two images of a Euclidean contractive affine IFS.

### C. Higher-dimensional extension with two maps

For each integer $n\ge3$, use a nondegenerate **$n$-simplex**

$$
\Delta=\mathrm{conv}\{v_0,\ldots,v_n\}\subset\mathbb R^n
$$

as the full-dimensional analogue of a tetrahedron. Cut it by a prescribed affine hyperplane into two full-dimensional pieces and seek **exactly two** strict contractions whose images of $\Delta$ are precisely those pieces. Classify which cuts permit affine solutions, and identify obstructions for the others.

For a canonical split into two $n$-simplices, choose $M\in\mathrm{relint}[v_0,v_1]$ and use the hyperplane

$$
H=\mathrm{aff}\{M,v_2,\ldots,v_n\}.
$$

The target pieces are

$$
\Delta_1=\mathrm{conv}\{v_0,M,v_2,\ldots,v_n\},\qquad
\Delta_2=\mathrm{conv}\{M,v_1,v_2,\ldots,v_n\}.
$$

Find explicit necessary and sufficient conditions for two strict Euclidean affine contractions mapping $\Delta$ onto these prescribed pieces, or produce rigorous obstructions. A literal tetrahedron embedded in $\mathbb R^n$ remains three-dimensional; it is a separate embedded version of Part B, not a full-dimensional $n$-simplex.

### What counts as a resolution?

- Specify the quantifiers: one example, a characterized family, or every simplex and cut in the stated class.
- Specify the map class and metric. A spectral-radius calculation alone does not prove strict Euclidean contraction; a construction in a common equivalent metric or with nonlinear maps must be labeled as a separate variant.
- Provide formulas or a reproducible construction, verify $g_i(K)=K_i$, prove strict contractivity, and establish the attractor conclusion.
- For a negative result, state the failed assertion and prove an explicit obstruction or counterexample.
- Supply a written proof and, where feasible, a Lean 4 formalization with reproducible verification.
- Compare with the literature before claiming novelty. These are research questions; no assertion is made that every subcase is previously unsolved.

**Research lineage:** this challenge uses the verified four-map triangular seed of RC-000002-RIS-MO and is related to the two-map tetrahedron question in RC-000001-RIS-M0. It does not claim to resolve that earlier question.
