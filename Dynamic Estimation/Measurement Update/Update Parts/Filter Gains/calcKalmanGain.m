function W=calcKalmanGain(R,PzPred,otherInfo)
%%CALCKALMANGAIN Using the output of the Kalman filter measurement
%           prediction function KalmanMeasPred and the covariance
%           matrix of a measurement R, compute the gain of a Kalman filter.
%           This function can be useful for creating a gain based on some
%           type of "maximum" covariance matrix for a scene for purposes of
%           giving it to the calcMissedGateCov function to determine how
%           the covariance matrix of the target state prediction should be
%           increased for a missed-detection event when gating is
%           performed.
%
%INPUTS: R The zDimXzDim measurement covariance matrix.
%   PzPred The zDimXzDim covariance matrix of the measurement predicted by
%          the filter. 
% otherInfo The structure returned by the KalmanMeasPred function that
%          includes various terms that can be reused.
%
%OUTPUTS: W The xDimXzDim gain matrix used in the filter.
%
%This function produces the gain in the same manner as is done in
%KalmanUpdateWithPred and KalmanUpdate. See the comments to those functions
%for more information.
%
%EXAMPLE:
%Here, we demonstrate that the gain used in a complete update is the same
%as that obtained using just the prediction via KalmanMeasPred and then
%calcKalmanGain for the gain without using the measurement z itself.
% xPred=[1e3;-2e3;100;200];
% PPred=[28,   3.5,    6,  8.5;
%      3.5,    23,  8.5,   11;
%        6,   8.5,   18, 13.5;
%      8.5,    11, 13.5,   13];
% z=1e3*[-5.498856156296510;
%        1.199241491470584];
% R=eye(2);
% H=[0, 4, 9, 8;
%    6, 3, 0, 6];
% [~,~,~,~,W]=KalmanUpdate(xPred,PPred,z,R,H);
% [~,PzPred,otherInfo]=KalmanMeasPred(xPred,PPred,H);
% W1=calcKalmanGain(R,PzPred,otherInfo);
% %One will see that the result below is true (1).
% all(W1(:)==W(:))
%
%June 2018 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

Pxz=otherInfo.Pxz;

Pzz=PzPred+R;
W=Pxz/Pzz;

end

%LICENSE:
%
%The source code is in the public domain and not licensed or under
%copyright. The information and software may be used freely by the public.
%As required by 17 U.S.C. 403, third parties producing copyrighted works
%consisting predominantly of the material produced by U.S. government
%agencies must provide notice with such work(s) identifying the U.S.
%Government material incorporated and stating that such material is not
%subject to copyright protection.
%
%Derived works shall not identify themselves in a manner that implies an
%endorsement by or an affiliation with the Naval Research Laboratory.
%
%RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE OF THE
%SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO INDEMNIFY THE NAVAL
%RESEARCH LABORATORY FOR ALL THIRD-PARTY CLAIMS RESULTING FROM THE ACTIONS
%OF RECIPIENT IN THE USE OF THE SOFTWARE.
