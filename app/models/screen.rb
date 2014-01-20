class Screen
  def self.demo
    [
     {
        id: 1,
        title: 'Logistics Monitoring',
        svg_file: ActionController::Base.helpers.asset_path('screens/screen1.svg')
     },
     {
        id: 2,
        title: 'Screen 2 details',
        svg_file: ActionController::Base.helpers.asset_path('screens/screen2.svg')
     }
    ]
  end
end
