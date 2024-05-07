data {
  
  // number of latent classes
  int C;
  
  // parameters for Dirichlet distribution
  vector[C] alpha;
  
}


generated quantities {
  
  vector[C] draws;
  draws = dirichlet_rng(alpha);
  
}


