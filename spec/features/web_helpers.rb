def sign_in_and_play
  visit('/')
  fill_in(:player1, with: 'Adil')
  fill_in(:player2, with: 'Nick')
  click_button 'submit'
end