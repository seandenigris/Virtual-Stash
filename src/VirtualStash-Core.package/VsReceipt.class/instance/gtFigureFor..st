accessing
gtFigureFor: aView
    <gtView>
    ^ aView pannable
        title: 'Figure';
        priority: 1;
        stencil: [ self asElement ]