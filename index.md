---
layout: home
profile_picture:
  src: /assets/img/headshot.png
  alt: website picture
---

**PhD Candidate** • [Harvard-MIT Health Sciences and Technology](https://hst.mit.edu/) \\
*Group*: [Computer Science and Artificial Intelligence Laboratory](https://www.csail.mit.edu/) \\
*Advisor*: [Dr. Polina Golland](https://people.csail.mit.edu/polina/)

I am a PhD student at the Harvard-MIT Program in Health Sciences and Technology, advised by Polina Golland. My research combines computer vision and medical physics to develop spatial models that can extract quantitative 3D/4D information from widely used 2D medical modalities, such as X-ray and ultrasound. My work uses these models to solve unmet clinical needs in diagnostics, image-guided interventions, and surgical robotics.

<center>
  <a href="mailto:vivekg@mit.edu">Email</a> •
  <a href="/assets/Vivek_Gopalakrishnan_CV.pdf">CV</a> •
  <a href="https://scholar.google.com/citations?user=kYGmJpAAAAAJ&hl=en">Google Scholar</a> •
  <a href="https://github.com/eigenvivek">GitHub</a>
</center>

## Research

<style>
  .image-text-block {
    display: flex;
    align-items: flex-start;
    margin-bottom: 20px;
  }

  .image-text-block img {
    width: 175px;
    height: 175px;
    margin-right: 20px;
  }

  .image-text-block div {
    max-width: 600px;
  }

  .image-text-block p {
    margin: 0; /* Remove default paragraph margin */
  }

  .strong-title {
    font-weight: bold;
    display: inline; /* Keep title inline */
  }

  .author-list {
    list-style-type: none;
    margin: 0;
    padding: 0;
  }

  .author-list a {
    margin-right: 0px;
  }

  .journal-year {
    color: #666;
    margin-bottom: 0; /* Remove space after the journal */
  }

  .links {
    margin-bottom: 10px; /* Remove space before the links */
  }
</style>


### Differentiable Rendering + Minimally Invasive Surgery

<div class="image-text-block">
  <img src="/assets/img/polypose.png" alt="polypose">
  <div>
    <p><strong class="strong-title"><a href="https://arxiv.org/abs/2505.19256">PolyPose: Localizing Deformable Anatomy in 3D from Sparse 2D X-ray Images using Polyrigid Transforms</a></strong></p>
    <p class="author-list">
      <b>Vivek Gopalakrishnan</b>,
      <a href="https://www.neeldey.com/">Neel Dey</a>,
      <a href="https://people.csail.mit.edu/polina">Polina Golland</a>
    </p>
    <p class="journal-year"><em>NeurIPS</em>, 2025</p>
    <div class="links">
      <a href="https://github.com/eigenvivek/polypose">code</a> / 
      <a href="/assets/papers/polypose.pdf">paper</a>
    </div>
    <p><code>PolyPose</code> is a fully deformable 2D/3D registration framework that accurately solves highly ill-constrained sparse-view and limited-angle registration with polyrigid transforms.</p>
  </div>
</div>

<div class="image-text-block">
  <img src="/assets/img/xvr.png" alt="xvr">
  <div>
    <p><strong class="strong-title"><a href="https://arxiv.org/abs/2503.16309">Rapid Patient-Specific Neural Networks for Intraoperative X-ray to Volume Registration</a></strong></p>
    <p class="author-list">
      <b>Vivek Gopalakrishnan</b>,
      <a href="https://www.neeldey.com/">Neel Dey</a>,
      <a href="https://www.researchgate.net/profile/David-Chlorogiannis">David-Dimitris Chlorogiannis</a>,
      <a href="https://www.linkedin.com/in/androwis">Andrew Abumoussa</a>,
      Anna M. Larson,
      <a href="https://www.childrenshospital.org/directory/darren-b-orbach">Darren B. Orbach</a>,
      <a href="https://golbylab.bwh.harvard.edu/sarah-frisken-phd/">Sarah Frisken</a>,
      <a href="https://people.csail.mit.edu/polina">Polina Golland</a>
    </p>
    <p class="journal-year"><em>arXiv</em>, 2025</p>
    <div class="links">
      <a href="https://xvr.csail.mit.edu">project page</a> / 
      <a href="https://github.com/eigenvivek/xvr">code</a> / 
      <a href="https://github.com/eigenvivek/xvr#usage">docs</a> / 
      <a href="https://arxiv.org/abs/2503.16309">paper</a>
    </div>
    <p>We present <code>xvr</code>, a CLI/API for training patient-specific 2D/3D registration in models in 5 minutes (100x faster than <code>DiffPose</code>).</p>
  </div>
</div>

<div class="image-text-block">
  <img src="/assets/img/diffpose.gif" alt="pelvis.html">
  <div>
    <p><strong class="strong-title"><a href="https://arxiv.org/abs/2312.06358">Intraoperative 2D/3D Image Registration via Differentiable X-ray Rendering</a></strong></p>
    <p class="author-list">
      <b>Vivek Gopalakrishnan</b>,
      <a href="https://www.neeldey.com/">Neel Dey</a>,
      <a href="https://people.csail.mit.edu/polina">Polina Golland</a>
    </p>
    <p class="journal-year"><em>CVPR</em>, 2024</p>
    <div class="links">
      <a href="https://vivekg.dev/DiffPose">project page</a> / 
      <a href="https://github.com/eigenvivek/DiffPose">code</a> / 
      <a href="https://arxiv.org/abs/2312.06358">paper</a>
    </div>
    <p>We use X-ray renderering to develop <code>DiffPose</code>, a self-supervised framework for differentiable 2D/3D image registration that achieves sub-millimeter registration accuracy.</p>
  </div>
</div>

<!-- <div class="image-text-block">
  <img src="/assets/img/spine.gif" alt="spine.html">
  <div>
    <p><strong class="strong-title"><a href="https://thejns.org/focus/view/journals/neurosurg-focus/54/6/article-pE16.xml">Machine Learning for Automated and Real-Time 2D/3D Registration of the Spine using a Single Radiograph</a></strong></p>
    <p class="author-list">
      <a href="#">Andrew Abumoussa</a>,
      <b>Vivek Gopalakrishnan</b>,
      <a href="#">Benjamin Succop</a>,
      <a href="#">Michael Galgano</a>,
      <a href="#">Sivakumar Jaikumar</a>,
      <a href="#">Yeuh Z. Lee</a>,
      <a href="#">Deb A. Bhowmick</a>
    </p>
    <p class="journal-year"><em>Neurosurgical Focus</em>, 2023</p>
    <div class="links">
      <a href="https://thejns.org/focus/view/journals/neurosurg-focus/54/6/article-pE16.xml">paper</a>
    </div>
    <p>We use <code>DiffDRR</code> to solve a 2D/3D registration problem in image-guided spinal surgery.</p>
  </div>
</div> -->

<div class="image-text-block">
  <img src="/assets/img/diffdrr.gif" alt="woowoowooooo">
  <div>
    <p><strong class="strong-title"><a href="https://arxiv.org/abs/2208.12737">Fast Auto-Differentiable Digitally Reconstructed Radiographs for Solving Inverse Problems in Intraoperative Imaging</a></strong></p>
    <p class="author-list">
      <b>Vivek Gopalakrishnan</b>,
      <a href="https://people.csail.mit.edu/polina">Polina Golland</a>
    </p>
    <p class="journal-year"><em>MICCAI Clinical Image-based Procedures Workshop</em>, 2022</p>
    <div class="links">
      <a href="https://github.com/eigenvivek/DiffDRR">code</a> / 
      <a href="https://vivekg.dev/DiffDRR">docs</a> / 
      <a href="https://arxiv.org/abs/2208.12737">paper</a>
    </div>
    <p>We present <code>DiffDRR</code>, a differentiable X-ray renderer that can be used to solve inverse problems in X-ray imaging with deep learning (e.g., registration or reconstruction).</p>
  </div>
</div>

### Drug Discovery

<div class="image-text-block">
  <img src="/assets/img/xellar.gif" alt="zstacks">
  <div>
    <p><strong class="strong-title"><a href="https://github.com/eigenvivek/zlearn">Learning Interpretable Single-Cell Morphological Profiles from 3D Cell Painting Images</a></strong></p>
    <p class="author-list">
      <b>Vivek Gopalakrishnan</b>,
      <a href="https://www.linkedin.com/in/jingzhe-ma">Jingzhe Ma</a>,
      <a href="https://scholar.google.com/citations?user=0DsebPAAAAAJ">Zhiyong Xie</a>
    </p>
    <p class="journal-year"><em>CVPRW</em>, 2024</p>
    <p class="journal-year"><em>Society of Biomolecular Imaging and Informatics</em>, 2023 <b>(President's Innovation Award)</b></p>
    <div class="links">
      <a href="https://github.com/eigenvivek/zlearn">project page</a> /
      <a href="https://arxiv.org/abs/2403.17615">paper</a>
    </div>
    <p>Supervised deep learning models are used ubiquitously throughout image-based drug discovery. We discover a mechanism by which these models cheat and propose an interpretability metric to quantify the level of confounding.</p>
  </div>
</div>

### Statistical Graph Theory

<div class="image-text-block">
  <img src="/assets/img/corpus-callosum.png" alt="corpus callosum">
  <div>
    <p><strong class="strong-title"><a href="https://doi.org/10.1162/IMAG.a.2">Multiscale Comparative Connectomics</a></strong></p>
    <p class="author-list">
      <b>Vivek Gopalakrishnan</b>,
      <a href="https://j1c.me/">Jaewon Chung</a>,
      <a href="https://ericwb.me/">Eric Bridgeford</a>,
      <a href="https://bdpedigo.github.io/">Benjamin D. Pedigo</a>,
      <a href="https://jesus-arroyo.github.io/">Jesús Arroyo</a>,
      <a href="https://www.linkedin.com/in/lucy-upchurch-a56a141">Lucy Upchurch</a>,
      <a href="https://bme.duke.edu/faculty/allan-johnson">G. Allan Johnson</a>,
      <a href="https://medicine.iu.edu/faculty/48212/wang-nian">Nian Wang</a>,
      <a href="https://www.ams.jhu.edu/~priebe/">Carey E. Priebe</a>,
      <a href="https://jovo.me/">Joushua T. Vogelstein</a>
    </p>
    <p class="journal-year"><em>Imaging Neuroscience</em>, 2025</p>
    <div class="links">
      <a href="https://github.com/neurodata/MCC">code</a> /
      <a href="https://doi.org/10.1162/IMAG.a.2">paper</a>
    </div>
    <p>
    We introduce a set of multiscale hypothesis tests to facilitate the robust and reproducible discovery of hierarchical brain structures that vary in relation with phenotypic profiles.
    </p>
  </div>
</div>

<div class="image-text-block">
  <img src="/assets/img/statistical-connectomics.png" alt="ASE clustering">
  <div>
    <p><strong class="strong-title"><a href="https://www.annualreviews.org/doi/abs/10.1146/annurev-statistics-042720-023234">Statistical  Connectomics</a></strong></p>
    <p class="author-list">
      <a href="https://j1c.me/">Jaewon Chung</a>,
      <a href="https://ericwb.me/">Eric Bridgeford</a>,
      <a href="https://jesus-arroyo.github.io/">Jesús Arroyo</a>,
      <a href="https://bdpedigo.github.io/">Benjamin D. Pedigo</a>,
      <a href="https://www.linkedin.com/in/ali-saad-eldin-09250317b">Ali Saad-Eldin</a>,
      <b>Vivek Gopalakrishnan</b>,
      <a href="#">Ling Xiang</a>,
      <a href="https://www.ams.jhu.edu/~priebe/">Carey E. Priebe</a>,
      <a href="https://jovo.me/">Joushua T. Vogelstein</a>
    </p>
    <p class="journal-year"><em>Annual Review of Statistics and Its Application</em>, 2021</p>
    <div class="links">
      <a href="https://github.com/microsoft/graspologic">code</a> /
      <a href="https://www.annualreviews.org/doi/abs/10.1146/annurev-statistics-042720-023234">paper</a>
    </div>
    <p>From a statistical graph theory perspective, we review models, assumptions, problems, and applications that are theoretically and empirically justified for analysis of connectome data.</p>
  </div>
</div>

<!-- ### Survival Analysis -->

<!-- My interests lie in the following areas in medicine and machine learning:

- **Neural fields** → spatiotemporal vessel reconstruction in neurosurgery
- **Differentiable rendering** → fast registration for intraoperative image guidance
- **Statistical graph theory** → biomarker discovery in network neuroscience
- **Matrix analysis** → no biomedical applications yet, but I do love a good eigenvalue property!

Before starting my PhD, I completed my BS/MS in Biomedical Engineering at Johns Hopkins University, where I worked with Dr. Joshua Vogelstein and Dr. Carey Priebe in the NeuroData Lab. My work is supported by a Neuroimaging Training Program Grant from the National Institute of Biomedical Imaging and Bioengineering. -->
