%let pgm=utl-rename-variables-using-a-mapping-in-a-second-table-r-namedvectors-and-sas-macro;

%stop_submission;

Rename variables using a mapping in a second table r namedvectors and sas macro

github
https://tinyurl.com/2upmcrrx
https://github.com/rogerjdeangelis/utl-rename-variables-using-a-mapping-in-a-second-table-r-namedvectors-and-sas-macro

stackoverflow
https://tinyurl.com/5n9axsvc
https://stackoverflow.com/questions/79381809/renaming-columns-based-on-variables-in-another-data-frame


    SOLUTIONS

        1 sas macro mapping

        2 r named vectors
          tidyverse language
            setNames()
            any_of()
          SOAPBOX ON
            I have had problems with named vectors in the past.
            Very diffuclt to convert them to dataframes,
            especially when a named vector is within a r list.
            R package output sometimes contain named vectors?
            Less is more.
          SOAPBOX OFF

This is a classic example of indirection using macro variables;

 At its core the sas macro language is about the maniulation of symbolsic structures.
    symput
    symget
    into :
 This example is presents the esssence of the macro languase.


/**************************************************************************************************************************/
/*                                        |                                             |                                 */
/*             INPUT                      |       PROCESS                               |      OUTPUT                     */
/*             =====                      |       ========                              |      =======                    */
/*                                        |                                             |                                 */
/*   SD1 HAVE                             | 1 SAS PROC DATASETS                         |  SD1.HAVE                       */
/*                                        |                                             |                                 */
/*   ID  VAR_2 VAR_5                      |   proc datasets lib=sd1 ;                   |  ID    MEENY    CATCH           */
/*                                        |     modify have;                            |                                 */
/*    1   12    22                        |     rename                                  |   1      12       22            */
/*    2   13    23                        |       var_2 = &var_2                        |   2      13       23            */
/*    3   14    24                        |       var_5 = &var_5;                       |   3      14       24            */
/*                                        |   run;quit;                                 |                                 */
/*   MAPPING                              |                                             |                                 */
/*                                        |                                             |                                 */
/*   ID   VAR    TES   MACRO MAPPING      |  2 R NAMED VECTOR TIDYVERSE LANGUAGE        |                                 */
/*                                        |                                             |                                 */
/*    1  VAR_1  EENY   &VAR_1 = eeny      |  lookup <- setNames(map$VAR, map$TES)       |                                 */
/*    2  VAR_2  MEENY  &VAR_2 = meeny     |  have |> rename(any_of(lookup))             |                                 */
/*    3  VAR_3  MINY   &VAR_3 = miny      |                                             |                                 */
/*    4  VAR_4  MOE    &VAR_4 = moe       |                                             |                                 */
/*    5  VAR_5  CATCH  &VAR_5 = catch     |                                             |                                 */
/*    6  VAR_6  TIGER  &VAR_6 = tiger     |                                             |                                 */
/*    7  VAR_7  TOE    &VAR_7 = toe       |                                             |                                 */
/*                                        |                                             |                                 */
/*  options                               |                                             |                                 */
/*   validvarname=upcase;                 |                                             |                                 */
/*  libname sd1 "d:/sd1";                 |                                             |                                 */
/*  data sd1.have;                        |                                             |                                 */
/*   input id var_2 var_5;                |                                             |                                 */
/*  cards4;                               |                                             |                                 */
/*  1 12 22                               |                                             |                                 */
/*  2 13 23                               |                                             |                                 */
/*  3 14 24                               |                                             |                                 */
/*  ;;;;                                  |                                             |                                 */
/*  run;quit;                             |                                             |                                 */
/*                                        |                                             |                                 */
/*  * MAPPING;                            |                                             |                                 */
/*                                        |                                             |                                 */
/*  data sd1.map;                         |                                             |                                 */
/*    input id var$ tes$;                 |                                             |                                 */
/*    call symputx(var,tes,'G');          |                                             |                                 */
/*  cards4;                               |                                             |                                 */
/*  1 VAR_1 EENY                          |                                             |                                 */
/*  2 VAR_2 MEENY                         |                                             |                                 */
/*  3 VAR_3 MINY                          |                                             |                                 */
/*  4 VAR_4 MOE                           |                                             |                                 */
/*  5 VAR_5 CATCH                         |                                             |                                 */
/*  6 VAR_6 TIGER                         |                                             |                                 */
/*  7 VAR_7 TOE                           |                                             |                                 */
/*  ;;;;                                  |                                             |                                 */
/*  run;quit;                             |                                             |                                 */
/*                                        |                                             |                                 */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

library sd1 "d:/sd1";

options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input id var_2 var_5;
cards4;
1 12 22
2 13 23
3 14 24
;;;;
run;quit;

* MAPPING;

data sd1.map;
  input id var$ tes$;
  call symputx(var,tes,'G');
cards4;
1 VAR_1 EENY
2 VAR_2 MEENY
3 VAR_3 MINY
4 VAR_4 MOE
5 VAR_5 CATCH
6 VAR_6 TIGER
7 VAR_7 TOE
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* SD1 HAVE                                                                                                               */
/*                                                                                                                        */
/* ID  VAR_2 VAR_5                                                                                                        */
/*                                                                                                                        */
/*  1   12    22                                                                                                          */
/*  2   13    23                                                                                                          */
/*  3   14    24                                                                                                          */
/*                                                                                                                        */
/* MAPPING                                                                                                                */
/*                                                                                                                        */
/* ID   VAR    TES   MACRO MAPPING                                                                                        */
/*                                                                                                                        */
/*  1  VAR_1  EENY   &VAR_1 = eeny                                                                                        */
/*  2  VAR_2  MEENY  &VAR_2 = meeny                                                                                       */
/*  3  VAR_3  MINY   &VAR_3 = miny                                                                                        */
/*  4  VAR_4  MOE    &VAR_4 = moe                                                                                         */
/*  5  VAR_5  CATCH  &VAR_5 = catch                                                                                       */
/*  6  VAR_6  TIGER  &VAR_6 = tiger                                                                                       */
/*  7  VAR_7  TOE    &VAR_7 = toe                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                                                                               _
/ |  ___  __ _ ___   _ __ ___   __ _  ___ _ __ ___   _ __ ___   __ _ _ __  _ __ (_)_ __   __ _
| | / __|/ _` / __| | `_ ` _ \ / _` |/ __| `__/ _ \ | `_ ` _ \ / _` | `_ \| `_ \| | `_ \ / _` |
| | \__ \ (_| \__ \ | | | | | | (_| | (__| | | (_) || | | | | | (_| | |_) | |_) | | | | | (_| |
|_| |___/\__,_|___/ |_| |_| |_|\__,_|\___|_|  \___/ |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |
                                                                    |_|   |_|            |___/
*/

/*--- so you can rerun ----*/
options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input id var_2 var_5;
cards4;
1 12 22
2 13 23
3 14 24
;;;;
run;quit;

proc datasets lib=sd1 ;
  modify have;
  rename
    var_2 = &var_2
    var_5 = &var_5;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  ID    MEENY    CATCH                                                                                                  */
/*                                                                                                                        */
/*   1      12       22                                                                                                   */
/*   2      13       23                                                                                                   */
/*   3      14       24                                                                                                   */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*___                                          _                  _
|___ \   _ __   _ __   __ _ _ __ ___   ___  __| | __   _____  ___| |_ ___  _ __
  __) | | `__| | `_ \ / _` | `_ ` _ \ / _ \/ _` | \ \ / / _ \/ __| __/ _ \| `__|
 / __/  | |    | | | | (_| | | | | | |  __/ (_| |  \ V /  __/ (__| || (_) | |
|_____| |_|    |_| |_|\__,_|_| |_| |_|\___|\__,_|   \_/ \___|\___|\__\___/|_|
*/

/*--- so you can rerun ----*/
options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input id var_2 var_5;
cards4;
1 12 22
2 13 23
3 14 24
;;;;
run;quit;

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(tidyverse)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
map<-read_sas("d:/sd1/map.sas7bdat")
print(map)
lookup <- setNames(map$VAR, map$TES)
want<-have |> rename(any_of(lookup))
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                     |                                                                                                  */
/*   R                 |   SAS                                                                                            */
/*                     |                                                                                                  */
/*  ID MEENY CATCH     |   ROWNAMES    ID    MEENY    CATCH                                                               */
/*                     |                                                                                                  */
/*   1    12    22     |       1        1      12       22                                                                */
/*   2    13    23     |       2        2      13       23                                                                */
/*   3    14    24     |       3        3      14       24                                                                */
/*                     |                                                                                                  */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
