class BeaconsController < UITableViewController
  def viewDidLoad
    @beacons = []
    view.dataSource = view.delegate = self
    SensoroBeaconManager.start_listening do |what, beacon|
      case what
        when :beacon_found
          @beacons << beacon
        when :beacon_lost
          @beacons.delete(beacon)
      end
      view.reloadData 
    end
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @beacons.size
  end

  CellIdentifier = "beacons"
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CellIdentifier)
      cell.selectionStyle = UITableViewCellSelectionStyleBlue
      cell
    end
    cell.textLabel.text = @beacons[indexPath.row].serial_number
    cell
  end
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = BeaconsController.alloc.init
    rootViewController.title = 'Sensoro Listener'

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(rootViewController)
    @window.makeKeyAndVisible

    true
  end
end
