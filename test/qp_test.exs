defmodule QpTest do
  use ExUnit.Case

  test "Encoded then decoded text matches the original" do
    source = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed accumsan placerat interdum. Cras vitae neque feugiat, euismod leo a, viverra dolor. Praesent varius facilisis neque in tristique. Proin vehicula sit amet arcu sit amet rutrum. Praesent sit amet ipsum ac justo semper cursus vel et lorem. Nam malesuada semper lacus ut finibus. In consequat turpis ut quam eleifend, non bibendum nibh vestibulum. Nam a nisl tellus. Etiam congue turpis quis turpis tincidunt consequat et id lacus. Pellentesque feugiat varius dui, nec placerat sem tincidunt eget. Sed elementum porta neque et iaculis. Suspendisse commodo tincidunt auctor.
    Sed fringilla pellentesque luctus. Mauris interdum mollis risus, et congue diam accumsan eget. Vestibulum non ullamcorper libero. Sed et tempus eros. Duis scelerisque pellentesque lacus non fringilla. Proin eu aliquet mauris. Nunc aliquet magna libero, vel blandit urna bibendum et. Suspendisse eget diam fringilla, aliquam felis in, suscipit felis. Maecenas id faucibus dolor. Vestibulum aliquet, magna non condimentum ultricies, neque sem viverra tellus, quis porta tortor dui sit amet orci. Vestibulum volutpat ultrices lorem ac euismod.
    Curabitur eros ipsum, tristique sed hendrerit non, auctor ut erat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean at semper diam, nec posuere ligula. Proin congue, lorem vel porttitor auctor, nibh odio pellentesque tellus, sagittis congue est nisl nec quam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In aliquet velit sit amet mauris sollicitudin pharetra. Cras malesuada ipsum eget viverra laoreet. Donec ornare augue placerat dolor gravida, sed maximus elit tempus. Suspendisse tincidunt dui et tortor vestibulum, ut tristique lorem lobortis. Fusce dui leo, porttitor ut mollis dictum, feugiat feugiat nisi. Pellentesque quis ante id tortor elementum aliquet. Quisque magna purus, tristique vel rutrum vitae, dapibus eget diam. Quisque maximus hendrerit metus vitae auctor. Donec venenatis augue sem, nec feugiat nunc luctus id. Ut congue nulla quis leo mattis, quis tincidunt justo posuere.

    Mauris sed risus nisi. Nunc sodales ante non commodo dapibus. Vestibulum enim eros, gravida in turpis ut, viverra laoreet felis. Morbi sit amet nisl eleifend, tristique dolor non, interdum felis. Etiam nec interdum magna. Donec ornare iaculis massa pellentesque pulvinar. Aenean a lobortis tortor. Vivamus eget metus facilisis, sagittis nulla a, volutpat est. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac felis malesuada, volutpat sapien at, lacinia enim.

    Donec efficitur mauris a eros volutpat, eget varius velit laoreet. Morbi porta porta enim nec lobortis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed tempor justo ac urna maximus hendrerit. Etiam tristique est vitae magna cursus, imperdiet commodo leo interdum. Nam lacinia metus eu auctor rutrum. Integer nec porta ipsum.
    """
    assert source == Qp.decode(Qp.encode(source))
  end

  test "Encoded then decoded Unicode text matches original" do
    source = """
      Византија или Источно римско царство — продолжение на источниот дел од Римската империја во периодот на доцната антика и средниот век, каде претежно се говорело на грчки јазик.
      Главниот град на империјата бил Константинопол (денешен Истанбул), првично основан како Византион. Ја преживеал поделбата и падот на Западното римско царство во V век и продолжил
      да постои уште илјада години сè до падот во рацете на отоманските Турци во 1453 под водство на Мехмед Освојувачот. За време на нејзиното постоење, империјата била најмоќната економска,
      културна и воена сила во Европа. Двата поима, „Византија“ и „Источното римско царство“, се историографски термини создадени по крајот на царството. Нејзините граѓани продолжиле да
      посочуваат на нивната империја како Римска империја (старогрчки: Βασιλεία Ῥωμαίων, тр. Basileia Rhōmaiōn; латински: Imperium Romanum),[1] или Романија (Ῥωμανία), а себе се нарекувале
      „Римјани“.[2]
    """
    assert source == Qp.decode(Qp.encode(source))
  end

  test "Encoding matches pre-encoded, chunked text" do
    assert Qp.encode("Константинопол") == "=D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=D0=BD=D1=82=D0=B8=D0=BD=D0=BE=D0=BF=D0=\r\n=BE=D0=BB"
  end

end
