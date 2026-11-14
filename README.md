# RC-000002-RIS-MO

**Four-map affine IFS with a solid triangular attractor**  
**Hệ IFS affine bốn thành phần có attractor là tam giác đặc**

Author / đề xuất toán học: **S.S. Duymt / maitheduy**, F-Group.  
RC identifier: **RC-000002-RIS-MO** (the final character is the letter **O**, as requested).  
Prepared: **2026-11-14**. Version: **0.2.0**.

Repository: [https://github.com/maitheduy/RC-000002-RIS-MO-2](https://github.com/maitheduy/RC-000002-RIS-MO-2). The repository name ends in `-2`; the Research Capital identifier remains `RC-000002-RIS-MO`.

**Verification: PASSED_LEAN_GATE — local build and direct Lean check succeeded.**

## Core claim

Let

$$
T=\mathrm{conv}\{(0,0),(1,-1),(0,-1)\}
 =\{(x,y):0\le x\le -y\le1\},\qquad
L=\begin{pmatrix}-1/2&-1/2\\0&1/2\end{pmatrix}.
$$

Define

$$
\begin{aligned}
f_1(z)&=Lz,&f_2(z)&=Lz+(0,-1/2),\\
f_3(z)&=Lz+(1/2,-1/2),&f_4(z)&=-Lz+(1/2,-1).
\end{aligned}
$$

Then **T is the unique nonempty compact invariant set of this IFS**:

$$
T=f_1(T)\cup f_2(T)\cup f_3(T)\cup f_4(T).
$$

Each map is a strict Euclidean contraction. This RC records a concrete, reusable construction and proof; it does **not** claim a new class of plane tilings.

## Construction and mathematical proof

Take the midpoints

$$
M=(1/2,-1/2),\quad P=(1/2,-1),\quad Q=(0,-1/2).
$$

The ordered affine frame rule sends `(O,A,B)` to `(O,Q,M)`. It determines `L` by mapping the two source edge columns to their target columns. Translate the first image downward and diagonally to obtain the second and third maps; use central inversion and translation by `OP` for the fourth.

| Map | Images of `(O,A,B)` | Image triangle |
|---|---|---|
| f₁ | `(O,Q,M)` | OQM |
| f₂ | `(Q,B,P)` | QBP |
| f₃ | `(M,P,A)` | MPA |
| f₄ | `(P,M,Q)` | PMQ |

The midpoint construction covers T and the image interiors are disjoint. A detailed barycentric proof appears in `docs/name.tex`.

The exact Euclidean operator norm is `(1+sqrt(5))/4 < 1`. The Lean proof uses the simpler sufficient bound

$$
\|f_i(u)-f_i(v)\|_2^2\le\tfrac34\|u-v\|_2^2,
$$

so `sqrt(3)/2 < 1` is also a valid contraction factor. The bound is deliberately not asserted to be optimal.

For uniqueness, `L² = I/4`. Hence every two-step composition has linear part `+I/4` or `-I/4`, and is a contraction of factor `1/4` in the product sup metric. The formal proof shows that the Hausdorff distance `h` between any two nonempty compact invariant sets satisfies `h ≤ h/4`, whence `h=0` and the sets coincide. This proves uniqueness without adding Hutchinson's theorem as an unproved axiom.

## Formalization

Main source: `RC000002/Triangle.lean`. Entry point: `RC000002.lean`.

| Lean theorem | Meaning |
|---|---|
| `triangle_invariant` | Exact real-coordinate membership equivalence for the invariant set |
| `set_equation` | Four-image set union equals T |
| `euclidean_contraction_squared` | Certified squared Euclidean contraction bound |
| `two_step_difference` | Two-step differences are ± one quarter of the input difference |
| `two_step_contraction` | Two-step contraction in the sup metric |
| `triangle_compact`, `triangle_nonempty` | The candidate set is compact and nonempty |
| `compact_invariant_unique` | Reusable compact-set uniqueness lemma using Hausdorff distance |
| `unique_compact_attractor` | T is invariant and every nonempty compact invariant set equals T |

`Point = ℝ × ℝ` has Lean's product **sup metric**. The function `sqDist` is explicitly the squared **Euclidean** distance. They are kept distinct. Compactness is unaffected because these metrics induce the same topology on the plane. The Euclidean Lipschitz bound follows from the displayed squared inequality in ordinary mathematics; the exact optimal singular-value calculation belongs to the accompanying written proof.

The main formal theorem identifies the unique compact fixed set. It does not separately formalize Hausdorff convergence of arbitrary initial compact sets. That convergence also follows from the classical contractive-IFS theorem cited below.

## Reproduce

Install elan / Lean, unzip or clone this directory, and run:

```bash
lake exe cache get Mathlib.Topology.MetricSpace.HausdorffDistance Mathlib.Topology.Instances.Real.Lemmas Mathlib.Tactic.Linarith Mathlib.Tactic.NormNum Mathlib.Tactic.Ring Mathlib.Tactic.FinCases
lake build
lake env lean RC000002/Triangle.lean
python3 scripts/audit.py
```

Lean: **4.19.0**. Mathlib is pinned to commit **c44e0c8ee63ca166450922a373c7409c5d26b00b** (`v4.19.0`). `lake-manifest.json` records transitive dependencies. The source ends with `#print axioms` commands. Verification outputs and their meaning are documented in `verification/REPORT.md`.

GitHub Actions verification also passed: [Lean verification run #1](https://github.com/maitheduy/RC-000002-RIS-MO-2/actions/runs/43606518846), commit `1a5879b484a44835765a99c4e7c2ff7da358d34e`. The build, direct Lean check, and source audit succeeded. This hosted check confirms the verified seed; it does not resolve the Open Challenge.

## Scope, provenance, and lineage

- The coordinates, vertex ordering, and four-map construction were proposed by Dr.rer.nat Duymt in the research session of 14 November 2026.
- Proof development and packaging were assisted by ChatGPT. This is not an independent human peer review.
- The layout follows the author-supplied example [RC-000001-RIS-M0](https://github.com/maitheduy/RC-000001-RIS-M0), inspected at commit `fd65d2cbbb059dcb852e3e7632e4cbf5b87ad53e`.
- RC-000001 is a **format / conceptual predecessor**, not a mathematical dependency of this proof. This RC does not resolve its tetrahedron challenge.
- Novelty is **not established**. Medial subdivision is classical; relevant affine triangular IFS constructions already appear in Barnsley–Vince.
- Disjointness of interiors is proved in the written note; consult the formal theorem inventory for exactly what has been machine-checked.
- This version is published in the repository linked above. No DOI, license grant, or independent peer review is claimed. Licensing remains with the author.

## Open Challenge: Two-Map Contractive IFS for Prescribed Simplex Partitions

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

## References

1. J. E. Hutchinson, *Fractals and Self Similarity*, Indiana University Mathematics Journal **30**(5), 713–747 (1981). DOI: [10.1512/iumj.1981.30.30055](https://doi.org/10.1512/iumj.1981.30.30055).
2. M. Barnsley and A. Vince, *Fractal Tilings from Iterated Function Systems*, Discrete & Computational Geometry **51**(3), 729–752 (2014), especially Example 3.14. DOI: [10.1007/s00454-014-9589-2](https://doi.org/10.1007/s00454-014-9589-2).
3. F. Brunck, *Iterated Medial Triangle Subdivision in Surfaces of Constant Curvature*, Discrete & Computational Geometry **70**, 1059–1089 (2023). DOI: [10.1007/s00454-023-00500-5](https://doi.org/10.1007/s00454-023-00500-5).
4. M. S. Floater, *Generalized Barycentric Coordinates and Applications*, Acta Numerica **24**, 161–214 (2015). DOI: [10.1017/S0962492914000129](https://doi.org/10.1017/S0962492914000129).
5. S.S. Duymt, *Research Capital: Từ một viên gạch đến một hệ sinh thái tiến hóa của tri thức* (2026), [author-supplied Zenodo record](https://zenodo.org/records/24117869).

Full BibTeX entries and the supplied LaTeX style are included under `docs/`.

## Metadata and package layout

`info.yaml` is the canonical metadata file. `infor.yaml` is an identical compatibility copy included under the filename requested by the author. Keep them synchronized. `OPEN_CHALLENGE.md` contains a standalone English version of the challenge. The Lean sources and their verification scope are unchanged in version 0.2.0.

