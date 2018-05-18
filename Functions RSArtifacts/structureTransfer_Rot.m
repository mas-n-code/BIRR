function [s_destination]= structureTransfer_Rot(s_source,s_destination)
s_destination.ImageMetrics.Tumor.XYMax    =s_source.ImageMetrics.Tumor.XYMax;
s_destination.ImageMetrics.Fibro.XYMax    =s_source.ImageMetrics.Fibro.XYMax;
s_destination.ImageMetrics.Back.XYMax     =s_source.ImageMetrics.Back.XYMax;