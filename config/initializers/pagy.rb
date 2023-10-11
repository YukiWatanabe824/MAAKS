require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 10
Pagy::DEFAULT[:size]  = [1,2,2,1]
Pagy::DEFAULT[:overflow] = :last_page
