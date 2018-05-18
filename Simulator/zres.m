function deltaz=zres(nu,R,ri,zi,f); 
deltaz=nu*sqrt(R^2+ri^2+zi^2)/(4*f*zi*2);