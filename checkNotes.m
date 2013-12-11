function [status, file] = checkNotes(input, fileName)

dans = 'g3e3f3e3g2e3f3a2b2C3c3g3e3f3e3g2e3nf3a2b2C3c3e2g2g2f2a2A2d3d3g2e3c3nf3d3g3a2b2C3c3C3c3';
julpolska = 'G3g3a3G3E3e3f3E3D3d3e3d3b2c3d3e3f3G3nG3g3a3G3D3g3a3B3C4E3F3G3nc3c3c3d3e3d3c3d3E3C3d3d3d3e3f3e3d3e3F3D3ne3f3G3f3e3f3g3A3g3f3g3a3B3a3g3C4C4';
allegro = 'd3b2d3g3d3b2d3b2g2f2a2d2f2a2c3e3c3a2f2d2f2g2d2g2b2d3b2g3d3b2d3b2g2nf2a2d2f2a2c3e3c3a2f2d2f2G2a2d3f3c3e3a2c3e3c3d3f3a2d3f3d3ne3g3e3c3a2c3d3f3a3g3b3a3c3e3a2c3e3c3d3f3a2d3f3d3e3g3b3g3e3c3D3';
titanic = 'G2g2G2G2F2G2F2G2nG2g2G2G2F2G2nG2g2G2G2F2G2F2A2nG2g2G2G2F2G2nD2C3b2a2B2C3nA2G2F2F2nD2C3b2a2B2C3nA2G2F2G2F2A2';
pippi = 'C2F2A2F2b2a2g2f2E2G2C2E2nC2F2A2F2b2a2g2f2E2G2C2E2nA2a2a2A2A2B2a2a2G2g2g2G2f2f2E2F2nA2a2a2A2A2B2A2G2G2F2E2';
vingar = 'b2d3G3B3D3e3c3b2d3a3b3C4A3F3D3ng3a3B3B3B3a3g3B3A3B3E3F3G3E3b2d3nG3B3D3e3c3b2d3a3b3C4B3F3D3';
jul = 'C3A3c3e3G3f3a3B3f3g3A3a3G3e3f3D3e3c3nC3f3D3f3g3B3g3f3E3g3b3C3a3g3nF3e3d3E3d3c3D3c3b2C3a2c3F3d3C3e3f3F3E3nC3A3c3e3G3f3a3B3f3g3A3a3G3e3f3D3e3c3nC3A3c3e3G3f3a3B3f3g3A3a3G3e3f3D3e3c3nf3g3f3E3g3b3C4a3g3F3e3d3E3d3c3nD3c3b2C3a2c3F3d3C3F3E3';
allemande = 'f3c3c3f3g3c3c3g3a3f3a3g3c3c3g3a3f3a3g3f3g3c3c3nf3d3f3d3g3e3g3e3a3f3a3f3ne3c3f3a2b2f3c3e3F3f3c3c3f3g3c3c3g3g3c3c3g3ng3c3c3f3d3f3d3e3c3e3c3nb2g2C3C3B2';

if strcmp(fileName, 'img/im1s.jpg') == 1 || strcmp(fileName, 'img/im1c.jpg') == 1
   file = dans;
elseif strcmp(fileName, 'img/im3s.jpg') == 1
    file = julpolska;
elseif strcmp(fileName, 'img/im5s.jpg') == 1
    file = allegro;
elseif strcmp(fileName, 'img/im6s.jpg') == 1
    file = titanic;
elseif strcmp(fileName, 'img/im8s.jpg') == 1
    file = pippi;
elseif strcmp(fileName, 'img/im9s.jpg') == 1
    file = vingar;
elseif strcmp(fileName, 'img/im10s.jpg') == 1
    file = jul;
elseif strcmp(fileName, 'img/im13s.jpg') == 1
    file = allemande;
else
    file = 0;
end

fileSize = numel(file);
inputSize = numel(input);

if fileSize == inputSize
    if (file == input)
       status = 'Correct';
    else
        status = 'Some notes were incorrect';
    end
else
   status = 'Wrong number of notes'; 
end
end