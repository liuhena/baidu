// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

scalar dummyScalar;
scalar fScalarIsForced=0;
scalar fScalarIsReleased=0;
scalar fScalarHasChanged=0;
scalar fForceFromNonRoot=0;
scalar fNettypeIsForced=0;
scalar fNettypeIsReleased=0;
void  hsG_0 (struct dummyq_struct * I1042, EBLK  * I1043, U  I635);
void  hsG_0 (struct dummyq_struct * I1042, EBLK  * I1043, U  I635)
{
    U  I1272;
    U  I1273;
    U  I1274;
    struct futq * I1275;
    I1272 = ((U )vcs_clocks) + I635;
    I1274 = I1272 & 0xfff;
    I1043->I678 = (EBLK  *)(-1);
    I1043->I682 = I1272;
    if (I1272 < (U )vcs_clocks) {
        I1273 = ((U  *)&vcs_clocks)[1];
        sched_millenium(I1042, I1043, I1273 + 1, I1272);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I635 == 1)) {
        I1043->I683 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I678 = I1043;
        peblkFutQ1Tail = I1043;
    }
    else if ((I1275 = I1042->I1007[I1274].I695)) {
        I1043->I683 = (struct eblk *)I1275->I694;
        I1275->I694->I678 = (RP )I1043;
        I1275->I694 = (RmaEblk  *)I1043;
    }
    else {
        sched_hsopt(I1042, I1043, I1272);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
