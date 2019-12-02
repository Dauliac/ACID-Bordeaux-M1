function [y] = droite2DVd(x,vd,p)
% calcul des points d'une droite etant donnes son vecteur directeur
% vd et un point de la droite p
p
part1=(vd(2)/vd(1))
part2=(x- p(1)) + p(2)

y = part1 * part2;
end


