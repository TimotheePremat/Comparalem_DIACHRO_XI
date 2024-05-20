# SED for NCA4 | DIACHRO XI, 2024

> This file contains the commands used for data-collection for the talk _Comparalem, outil pour une phonétique historique de corpus_ (Premat 2024). It aims at making the results understandable and reproductible.

For all inquiries, use Concordance commands, and set first column to ```word, pos, ttpos, rrnpos, ttlemma, rnnlemma, subcorpus_id, (position)```
> Because NCA4 is not structured as is NCA3, using the Index command (as done in Premat 2023) do not allow for the necessary properties to be gathered. Thus, use only Concordance commands, and delete what is unnecessary using the SED scripts.

# General inquiries
> General inquiries are used to find lemmas with variation (Comparalem step 1). They can be done with different tags.

- all adverbs
	- following Dees pos
		- ```[pos="ADV"]```
		- qty: 208 314
	- following TreeTagger pos
		- ```[ttpos="ADV"]```
		- qty: 209 107
	- following RNN pos
		- ```[rnnpos="ADV.*"]```
		- qty: 298 364

- all adverbs not ending on _-e_ or _-es_
	- following Dees pos
		- ```[pos="ADV" & word!=".*e" & word!=".*es"]```
		- qty: 182 531
	- following TreeTagger pos
		- ```[ttpos="ADV" & word!=".*e" & word!=".*es"]```
		- qty: 182 187
	- following RNN pos
		- ```[rnnpos="ADV.*" & word!=".*e" & word!=".*es"]```
		- qty: 227 860

- all adverbs ending on _-e_
	- following Dees pos
		- ```[pos="ADV" & word=".*e"]```
		- qty: 11 776
	- following TreeTagger pos
		- ```[ttpos="ADV" & word=".*e"]```
		- qty: 11 755
	- following RNN pos
		- ```[rnnpos="ADV.*" & word=".*e"]```
		- qty: 54 188

- all adverbs ending on _-es_
	- following Dees pos
		- ```[pos="ADV" & word=".*es"]```
		- qty: 14 007
	- following TreeTagger pos
		- ```[ttpos="ADV" & word=".*es"]```
		- qty: 14 165
	- following RNN pos
		- ```[rnnpos="ADV.*" & word=".*es"]```
		- qty: 16 316

## SED treatment for general inquiries
### Structure of the export from TXM
- Tags, left context, pivot and right context are separated by tabulations
- Properties of pivot, in first column, are separated by comma+space
	- deleting everything located after a tabulation (and an line end, but that's SED default) will delete the concordance-type information
	- ```LC_CTYPE=C  sed -E -e 's/\t.*//'  pos=ADV.csv > pos=ADV_cleaned.csv```
- Then we need to reshape the columns:
	- Tags and form were separated by coma+space
	- So we just need to remake the header and we will get a well-formed CSV
	- ```LC_CTYPE=C  sed -E -e 's/Référence/word, pos, ttpos, rrnpos, ttlemma, rnnlemma, subcorpus_id, position/'   pos=ADV_cleaned.csv > pos=ADV_cleaned2.csv```
- These commands are written into a script named ```SCR_clean_file.sh ```.
	- The script has to be made executable: ```chmod +x SCR_clean_file.sh```
	- Then just execute it with input file name, and it will generate a 'cleaned' output file :
		- ```./SCR_clean_file.sh [file name]```
		- e.g. ```./SCR_clean_file.sh pos=ADV.csv```

# Contextual inquiries
For each type of adverb (oxytons, paroxytons ending on _-e_, paroxytons ending on _-es_ by adjonction of an 'adverbial _-s_'), data is collected depending on the initial of the following word (#C or #V).
> For contextual inquiries, only Dees POS are used: they are the most trustworthy. However, we test the effect of the two different lemmas: from TreeTagger (```ttlemma```) and from RNN Tagger (```rnnlemma```).

Some graphems are problematic: "i", "u" and "v" can represent vowels or consonants.
- To be safe, only "i" and "u" followed by a consonant are considered vowels.
	- This is done by the following CQP expression: ```[word = "((a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û)|(i|u)(b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)).*"%c]```
	- which reads: find a word beginning by a vowel other than "i" or "u", or by "i" or "u" followed by a consonant.
- Same with consonants : only "i", "u" and "v" followed by a vowel are considered consonants.
	- ```[word = "((b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)|(u|v|i)(a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û)).*"%c]```
	- which reads: find a word beginning by a consonant other than "v", or by "u", "v", "i" followed by a vowel.
- Other refinements:
	- the following word can be "v" or "u" ("où"/"ou" in Mod.Fr.), but it can't be "i" or "j":
		- "j" or "i" as a standalone word can be the elided subject pronoun "je" (= C-initial) or the object pronoun or adverb "y" (= V-initial)
		- Thus, it is impossible to correctly predict if it is a consonant or a vowel. Further analysis could be done using the POS attribute of the following word, but it's not worth it (1582 occurrences of ADV + "i/j").
	- "u" and "i" are integrated in possible contexts after "u/v/i" consonantal
	- "uv" sequence stands for VC (it would not be edited "uv" if not: _uvrir_ etc.)
	- "vn" sequence stands for VC (there are not [vn] sequences word-initial in Old French)
- Results of these accommodations for "i", "u" and "v" have been screened in lexical tables and are considered trustworthy.

## For _-e_ adverbs
- Before #V:
	- ```[pos="ADV" & word=".*e"] [word = "(((a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û)|(i|u)(b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)).*|(u|v)|(vn.*)|(uv.*))"%c]```
	- qty: 3177
- Before #C:
	- ```[pos="ADV" & word=".*e"][word = "((b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)|(u|v|i)(a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û|i|u)).*"%c]```
	- qty: 7730

## For _-es_ adverbs
- Before #V:
	- ```[pos="ADV" & word=".*es"] [word = "(((a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û)|(i|u)(b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)).*|(u|v)|(vn.*)|(uv.*))"%c]```
	- qty: 2689
- Before #C:
	- ```[pos="ADV" & word=".*es"][word = "((b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)|(u|v|i)(a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û|i|u)).*"%c]```
	- qty: 10 643

## For non _-e(s)_ adverbs
- Before #V:
	- ```[pos="ADV" & word!=".*e" & word!=".*es"] [word = "(((a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û)|(i|u)(b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)).*|(u|v)|(vn.*)|(uv.*))"%c]```
	- qty: 43 481
- Before #C:
	- ```[pos="ADV" & word!=".*e" & word!=".*es"][word = "((b|c|d|f|g|j|k|l|m|n|p|q|r|s|t|w|x|z|ç)|(u|v|i)(a|e|o|y|ä|ë|ï|ö|ü|ÿ|á|é|í|ó|ú|à|è|ì|ò|ù|â|ê|î|ô|û|i|u)).*"%c]```
	- qty: 131 613

> Some contexts are missing: our contexts sums up to 199 333 occurrences. For reference, pos="ADV" have 208 314 occurrences; 8981 occurrences are missing. They are:
-  adverbs are followed by a punctuation
-  adverbs are followed by a quotation mark (single or double)
-  adverbs are followed by a "h"-initial word, which are excluded (aspiration is not _that_ regular in Old French, despite what grammars sometimes say, thus I exclude them not to introduce bias in the data; see Premat 2023 p. 192, 306)
-  adverbs are followed by the word "i/j", excluded (cf. supra).
- and 49 occurrences that escape our inquiries because of grapho-phonological normal situations (e.g. "vsé", "vraiment"); their number is too low to justify implementation.
- all missing contexts have be tested and validated; nothing else is missing in the data.

And... That's it! Here are the data needed for Comparalem:
- ```pos=ADV_word=e_C_cleaned.txt```: adverbs ending on _-e_ before C-initial word
- ```pos=ADV_word=e_V_cleaned.txt```: adverbs ending on _-e_ before V-initial word
- ```pos=ADV_word=es_C_cleaned.txt```: adverbs ending on _-es_ before C-initial word
- ```pos=ADV_word=es_V_cleaned.txt```: adverbs ending on _-es_ before V-initial word
- ```pos=ADV_word!=e_word!=es_C_cleaned.txt```: adverbs ending neither on _-e_ or _-es_ before C-initial word
- ```pos=ADV_word!=e_word!=es_V_cleaned.txt```: adverbs ending neither on _-e_ or _-es_ before C-initial word
Additionally, a file comprising the metadata of the texts is needed and provided: ```NCA_dates```. Comparalem do not use the metadata directly from the TXM corpus, because we propose a number of intervention on them (restitution of missing locations, etc.; see Premat 2023, p. 30-39).
> Note that the proposed cleaning script (```SCR_clean_raw.sh```) produces ```.txt``` files, but it makes not difference as R can import CSV-type tabular files in TXT format, and actually incorporate a call to the graphic interface to import files.

# References
- Dees, Anthonij (1987). _Atlas des formes linguistiques des textes littéraires de l’ancien français._ Tübingen : M. Neimeyer Verlag.
- NCA: Stein, Achim, Pierre Kunstmann & Martin-D. Glessgen (2006). _Nouveau Corpus d’Amsterdam. Corpus informatique de textes littéraires d'ancien français (ca 1150-1350)._ Établi par Anthonij Dees (Amsterdam : 1987), remanié par Achim Stein, Pierre Kunstmann et Martin-D. Gleßgen, Stuttgart : Institut für Linguistik/Romanistik.
- Premat, Timothée (2024). _Comparalem, outil pour une phonétique historique de corpus._ Talk at DIACHRO XI congress, Madrid, 24 May 2024.
- Premat, Timothée (2023). _La genèse de l’élision._ PhD thesis. Nice: Côte d’Azur University. ⟨[NNT:2023COAZ2051](https://www.theses.fr/2023COAZ2051)⟩ ⟨[tel-04574584](https://theses.hal.science/tel-04574584)⟩
