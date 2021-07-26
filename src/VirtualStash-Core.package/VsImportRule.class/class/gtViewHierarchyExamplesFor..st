accessing
gtViewHierarchyExamplesFor: aView
    <gtClassView>
    | examples |
	examples := self withAllSubclasses flatCollect: #gtExamplesContained.
    ^ ((GtExampleGroup withAll: examples) gtExamplesFor: aView)
        title: 'Examples, All' translated;
        priority: 17