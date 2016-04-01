function [costs, parents] = linear_selection( costs, children, r )

% This function goes through the children that have been generated
% and creates a batch of parents the same number as the number of children.
% It works by assigning a probability to each child based on the cost
% associated with that child. The probabilities are linear based on this
% and from 0 to 1 such that the children can be selected with a random
% uniform number: the ranges are set up such that each child has a range
% associated with its probability. 

