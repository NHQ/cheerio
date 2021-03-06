$ = require('../')
expect = require 'expect.js'

###
  Examples
###

fruits = '''
<ul id = "fruits">
  <li class = "apple">Apple</li>
  <li class = "orange">Orange</li>
  <li class = "pear">Pear</li>
</ul>  
'''.replace /(\n|\s{2})/g, ''

###
  Tests
###

describe '$(...)', ->
  describe '.append', ->
    
    it '() : should do nothing', ->
      expect($('#fruits', fruits).append()[0].name).to.equal('ul')
    
    it '(html) : should add element as last child', ->
      $fruits = $(fruits)
      $('#fruits', $fruits).append('<li class = "plum">Plum</li>')
      expect($('#fruits', $fruits).children(3).hasClass('plum')).to.be.ok
    
    it '($(...)) : should add element as last child', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
        
      $('#fruits', $fruits).append($plum)
      expect($('#fruits', $fruits).children(3).hasClass('plum')).to.be.ok
    
    it '($(...), html) : should add multiple elements as last children', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
      grape = '<li class = "grape">Grape</li>'
          
      $('#fruits', $fruits).append($plum, grape)
      expect($('#fruits', $fruits).children(3).hasClass('plum')).to.be.ok
      expect($('#fruits', $fruits).children(4).hasClass('grape')).to.be.ok
      
    it '(fn) : should add returned element as last child'
    
    it 'should maintain correct object state (Issue: #10)', ->
      obj = $("<div></div>")
        .append("<div><div></div></div>")
        .children()
        .children()
        .parent()

      expect(obj).to.be.ok
    
  describe '.prepend', ->
    
    it '() : should do nothing', ->
      expect($('#fruits', fruits).prepend()[0].name).to.equal('ul')
    
    it '(html) : should add element as first child', ->
      $fruits = $(fruits)
      $('#fruits', $fruits).prepend('<li class = "plum">Plum</li>')
      expect($('#fruits', $fruits).children(0).hasClass('plum')).to.be.ok
      
    it '($(...)) : should add element as first child', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
        
      $('#fruits', $fruits).prepend($plum)
      expect($('#fruits', $fruits).children(0).hasClass('plum')).to.be.ok
    
    it '(html, $(...), html) : should add multiple elements as first children', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
      grape = '<li class = "grape">Grape</li>'
          
      $('#fruits', $fruits).prepend($plum, grape)
      expect($('#fruits', $fruits).children(0).hasClass('plum')).to.be.ok
      expect($('#fruits', $fruits).children(1).hasClass('grape')).to.be.ok
    
    it '(fn) : should add returned element as first child'
    
  describe '.after', ->
    
    it '() : should do nothing', ->
      expect($('#fruits', fruits).after()[0].name).to.equal 'ul'
      
    it '(html) : should add element as next sibling', ->
      $fruits = $(fruits)
      grape = '<li class = "grape">Grape</li>'
        
      $('.apple', $fruits).after(grape)
      expect($('.apple', $fruits).next().hasClass('grape')).to.be.ok
    
    it '($(...)) : should add element as next sibling', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
      
      $('.apple', $fruits).after($plum)
      expect($('.apple', $fruits).next().hasClass('plum')).to.be.ok
    
    it '($(...), html) : should add multiple elements as next siblings', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
      grape = '<li class = "grape">Grape</li>'
        
      $('.apple', $fruits).after($plum, grape)
      expect($('.apple', $fruits).next().hasClass('plum')).to.be.ok
      expect($('.plum', $fruits).next().hasClass('grape')).to.be.ok
      
    it '(fn) : should add returned element as next sibling'
    
  describe '.before', ->
    
    it '() : should do nothing', ->
      expect($('#fruits', fruits).before()[0].name).to.equal 'ul'
    
    it '(html) : should add element as previous sibling', ->
      $fruits = $(fruits)
      grape = '<li class = "grape">Grape</li>'
        
      $('.apple', $fruits).before(grape)
      expect($('.apple', $fruits).prev().hasClass('grape')).to.be.ok
    
    it '($(...)) : should add element as previous sibling', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
      
      $('.apple', $fruits).before($plum)
      expect($('.apple', $fruits).prev().hasClass('plum')).to.be.ok
      
    it '($(...), html) : should add multiple elements as previous siblings', ->
      $fruits = $(fruits)
      $plum = $('<li class = "plum">Plum</li>')
      grape = '<li class = "grape">Grape</li>'
    
      $('.apple', $fruits).before($plum, grape)
      expect($('.apple', $fruits).prev().hasClass('grape')).to.be.ok
      expect($('.grape', $fruits).prev().hasClass('plum')).to.be.ok
      
    it '(fn) : should add returned element as previous sibling'
    
  describe '.remove', ->
    
    it '() : should remove selected elements', ->
      $fruits = $(fruits)
      $('.apple', $fruits).remove()
      expect($fruits.find('.apple')).to.have.length 0
    
    it '(selector) : should remove matching selected elements', ->
      $fruits = $(fruits)
      $('li', $fruits).remove('.apple')
      expect($fruits.find('.apple')).to.have.length 0
  
  
  describe '.replaceWith', ->
    it '(elem) : should replace one <li> tag with another', ->
      $fruits = $(fruits)
      plum = $('<li class = "plum">Plum</li>')
      $('.pear', $fruits).replaceWith(plum)
      expect($('.orange', $fruits).next().hasClass('plum')).to.be.ok
      expect($('.orange', $fruits).next().html()).to.equal 'Plum'
      
    it '(elem) : should replace the selected element with given element', ->
      src = $('<ul></ul>')
      elem = $('<h2>hi <span>there</span></h2>')
      
      replaced = src.replaceWith(elem)
      expect(replaced[0].parent.type).to.equal 'root'
      
      expect($.html(replaced[0].parent)).to.equal '<h2>hi <span>there</span></h2>'
      expect($.html(replaced)).to.equal '<ul></ul>'
      
    it '(elem) : should replace the single selected element with given element', ->
      src = $('<br/>')
      elem = $('<h2>hi <span>there</span></h2>')

      replaced = src.replaceWith(elem)
      expect(replaced[0].parent.type).to.equal 'root'
      expect($.html(replaced[0].parent)).to.equal '<h2>hi <span>there</span></h2>'
      
      expect($.html(replaced)).to.equal '<br/>'
          
    it '(str) : should accept strings', ->
      src = $('<br/>')

      replaced = src.replaceWith('<h2>hi <span>there</span></h2>')
      expect(replaced[0].parent.type).to.equal 'root'

      expect($.html(replaced[0].parent)).to.equal '<h2>hi <span>there</span></h2>'
      expect($.html(replaced)).to.equal '<br/>'

  describe '.empty', ->
    
    it '() : should remove all children from selected elements', ->
      $fruits = $(fruits)
      $('#fruits', $fruits).empty()
      expect($('#fruits', $fruits).children()).to.have.length 0
    
  describe '.html', ->
    it '() : should get the innerHTML for an element', ->
      $fruits = $(fruits)
      items = ['<li class="apple">Apple</li>',
               '<li class="orange">Orange</li>',
               '<li class="pear">Pear</li>']
                 
      items = items.join('')
      
      expect($('#fruits', $fruits).html()).to.equal items
    
    it '() : should get innerHTML even if its just text', ->
      item = '<li class = "pear">Pear</li>'
      expect($('.pear', item).html()).to.equal 'Pear'
    
    it '() : should return empty string if nothing inside', ->
      item = '<li></li>'
      expect($('li', item).html()).to.equal ''
    
    it '(html) : should set the html for its children', ->
      $fruits = $(fruits)
      $('#fruits', $fruits).html('<li class = "durian">Durian</li>')
      html = $('#fruits', $fruits).html()
      expect(html).to.equal '<li class="durian">Durian</li>'
    
  describe '.text', ->
    it '() : gets the text for a single element', ->
      expect($('.apple', fruits).text()).to.equal 'Apple'
      
    it '() : combines all text from children text nodes', ->
      expect($('#fruits', fruits).text()).to.equal 'AppleOrangePear'
      
    it '(text) : sets the text for the child node', ->
      $fruits = $(fruits)
      $('.apple', $fruits).text('Granny Smith Apple')
      expect($('.apple', $fruits)[0].children[0].data).to.equal 'Granny Smith Apple'
    
    it 'should allow functions as arguments', ->
      $fruits = $(fruits)
      $('.apple', $fruits).text (i, content) ->
        expect(i).to.equal 0
        expect(content).to.equal 'Apple'
        return 'whatever mate'
      
      expect($('.apple', $fruits)[0].children[0].data).to.equal 'whatever mate'
      
      
    