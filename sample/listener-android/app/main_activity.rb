class MainActivity < Android::App::ListActivity
  def onCreate(savedInstanceState)
    super

    self.listAdapter = Android::Widget::ArrayAdapter.new(self, Android::R::Layout::Simple_list_item_1, [])
    handle = Android::Os::Handler.new

    SensoroBeaconManager.context = self
    SensoroBeaconManager.start_listening do |what, beacon|
      serial = beacon.serialNumber
      case what
        when :beacon_found
          handle.post -> { listAdapter.add(serial) }
        when :beacon_lost
          handle.post -> { listAdapter.remove(serial) }
      end
    end
  end

  def onListItemClick(listview, view, position, id)
    puts "click"
  end
end
