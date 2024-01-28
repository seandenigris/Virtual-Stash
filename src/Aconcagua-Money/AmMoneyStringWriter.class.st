"
Printing money is more complicated than it may seem at first. While the computation is straightforward, there are many options depending on the use case. Here are some (and how I handle them):
- Should we print the fraction part? Sometimes you want to see the fraction part (e.g. how much money is in my account) and sometimes you don't (e.g. long term beudget planning). By default, I only show the fraction part if there *is* something to show.
- Should we show the commodity? By default, I omit it.
- How should we print negative numbers? I do not do anything special to handle this, although that could easily be added

It should be mentioned that these difficulties are not theoretical, but were learned the hard way as printing approaches proliferated in real world applications that used this project.
"
Class {
	#name : #AmMoneyStringWriter,
	#superclass : #Object,
	#traits : 'AmTMoneyStringWriter',
	#classTraits : 'AmTMoneyStringWriter classTrait',
	#category : #'Aconcagua-Money'
}
