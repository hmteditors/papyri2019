
# A Guide to Editing Papyri for the HMT

## Important Points

- Please read this document and follow its guidelines.
- The HMT's standards, practices, and values for edited texts are *different* from those of other projects, so read this, please!
- The papyri have been edited and published; those publications are available and are possessions for all time. We do not need to reproduce them. 
- If new editions try to mimic old publications and do not adhere to HMT standards, **they cannot contribute to the HMT, and everyone will have wasted their time.**
- Read the [Homer Multitext Editor's Guide](http://homermultitext.github.io/hmt-editors-guide/guide/)
- The HMT Editors have been refining the project's standards and practices for almost two decades. Our current automated build process integrates 98,722 uniquely cited pieces of data into a single coherent dataset. This can only work and grow if standards are rigorously applied. 

## Overview

The *Homer Multitext* is not a papyrology project, and so digital editions of Homeric papyri should follow the HMT's techical, scholarly, and editorial principles, even when those differ from what is common in the field of papyrology.

HMT texts are edited, and stored in archival form, as TEI XML document, using a **small and specific** subset of the TEI vocabulary.

The [Homer Multitext Editor's Guide](http://homermultitext.github.io/hmt-editors-guide/guide/) should be the arbiter of decisions when marking up any Iliadic text, from a manuscript or papyrus, for the HMT.

For the HMT to work, all texts must be compliant with the Canonical Text Services protocol, which is an implementation of a specific abstract model of "text". It is important to understand this model, since it guides many editorial decisions.

The model is "OHCO2", which states that a "text" is "an ordered hiearchy of *citation* objects."[^ohco1] "Ordered," because we read a text from beginning to end. "Hierarchy," because the parts of a text may organized 1, 2, or more levels deep (Homeric texts have a 2-level hierarchy: Book / Line).

The "Citation Objects" part is important. While a papyrus fragment is a physical object, an HMT edition of Iliadic text is an edition of an Iliadic text, not an edition of a physical object. So for the HMT, the fundamental structure of an edition is Book + Poetic Lines, regardless of how those lines may be presented on the papyrus.

We have other ways of documenting physical objects and aligning passages of text to them, highly effective ways. But we are assiduous about separating the concern of "text" from "presentation of text" from "documentation of text-bearing surface."

We are also careful to separate the concerns textual data, versus metadata, commentary, argument, and bibliography. In a TEI XML edition of a fragment of Homeric Epic, there should be nothing in the `<text>…</text>` element that is not the text of the fragment or markup on that text that follows the HMT guidelines. 

Bibliography, publication history, commentary, and the like can be in an accompanying file (in XML or some other format), or (if possible) in the `<teiHeader>` element. 

**The point is machine-actionable texts, not electronic texts intended to facilitate printing for human readers.** This will be important in the case of specific issues, below.

## Specific Issues

### Where do we cite the original editors?

Give all information about dates, provenance, and bibliography that seems appropriate in the `<sourceDesc><p>…</p></sourceDesc>` element in the `<teiHeader>` element. Inside that `<p>` element, you can use plain-text, or [Markdown](https://www.markdowntutorial.com) formatting.

We can extract that text when we process the archival file, and either include it in the CTS catalog or link it to the text as a comment.

### Document Structure

Iliadic text goes in `<TEI><text><body>`.

The structure is:

~~~ XML
	<div n="11" type="book">
		<l n="502">Ἕκτωρ μὲν μετὰ τοῖσιν ὁμίλει…</l>
		<l n="503">ἔγχεΐ θ᾽ ἱπποσύνῃ τε, νέων δ᾽…</l>
		…
	</div>
	<div n="12" type="book">
		<l n="1">…</l>
		<l n="2">…</l>
		…
	</div>
~~~

**There is no other hierarchy except the citation-hierarchy.** We do not record columns, physical line-breaks, or other aspects of the physical document. Those are presumably recorded in the publication, which we do not need to reproduce.

If there is a single papyrus "text" spread across several physical fragments, those can be edited as one HMT edition or several (one for each fragment). The correct citations to the Iliadic text will keep them straight. Either way the only structure in the XML is that of Book+Line.

### Homeric Text and Other Text On One Document

Talk to Casey, Mary, Christopher, or Neel. 

If the non-Homeric text is *not* discussing the Homeric text, we will probably advise to omit it from the HMT edition of this papyrus, since there is a publication of the papyrus that contains everything, and we are simply interested in "the Homeric text as represented on Papyrus N." 

If the other text comments on the papyrus, talk to the HMT editors or Project Architects, and we can point to how to deal with this. The result will be at least two separate editions: one of the Homeric text, and one of the commentary text, both uniquely citable as **two distinct texts that happen to be present on the same physical surface.**

### Diplomatic vs. Normalized

…

### Wrapping Words

Because TEI-XML is ill-suited for much textual work, we need to be very careful to ensure that the *words* of the edition can be identified by our build-process.

If everything is clear, individual words within a line are delimited by white space. The HMT's analytical processes can easily distinguish the eight words in the markup below (note the Unicode straight single quotation mark for elision):

~~~ XML
<l n="503">ἔγχεΐ θ' ἱπποσύνῃ τε, νέων δ' ἀλάπαζε φάλαγγας</l>
~~~

But if a work has markup inside it, we cannot count on white-space to define the word:

~~~ XML
<unclear>ἠ</unclear>υκόμοιο
~~~

The vicissitudes of XML's handling of elements and markup might well trick a parser into seeing:

~~~ XML
ἠ υκόμοιο
~~~

So when there is markup *within* a word, we need to define the whole word explicitly, with a `<w>` element:

~~~ XML
<w><unclear>ἠ</unclear>υκόμοιο</w>
~~~

The HMT parsers and tokenizers know to look for `<w>…</w>` first, tokenize those, and then default to white-space delimited words.


### Gaps and Supplied

The point of the HMT and its technological infrastructure is that we can use CTS URNs to compare passages of text. So, there is really no reason to use `<supplied>` in markup. For example, a traditional papyrological edition might have, in a fragment of *Iliad* 11.528: `<w>ἵπ<supplied reason="lost">πους</supplied></w>`. For the HMT, we leave the gap empty, and write `<w>ἵπ<gap unit="letters" extent="4"/></w>`.

We are aware that this may seem to undo the work of past editors. Their publications remain on record and available for readers, and can be (and ought to be) cited in the `<teiHeader>` element. HMT editions of papyri should *not* include modern editorial reconstructions.

(Ancient scribal corrections, deletions, or additions should be included, and the Editor's Guide has examples of how to do this.)


[^ohco1]: The original OHCO model stated that a "text" was an "ordered hiearchy of *content* objects," which immediately led to chaos and acrimony, since no one could agree on what "content" was.



