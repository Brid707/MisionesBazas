using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using MisionesBazas;
using System;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Data;

namespace MisionesBazas.view
{
    public partial class ScoreBoard : Window
    {
        private MisionesBazas_Experiencia_v4Entities _context = new MisionesBazas_Experiencia_v4Entities();
        private CollectionViewSource _userViewSource;

        public ScoreBoard()
        {
            InitializeComponent();
            _userViewSource = ((CollectionViewSource)(this.FindResource("userViewSource")));
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            _context.User.Include(u => u.Experience).Include(u => u.PlayerProfile).Load();

            int pos = 1;
            foreach (var user in _context.User.Local
                .OrderByDescending(u => u.Experience.TotalXP)
                .Take(3))
            {
                user.Position = pos++;
            }

            _userViewSource.Source = _context.User.Local.Where(u => u.Position > 0);
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        protected override void OnClosed(EventArgs e)
        {
            base.OnClosed(e);
            _context.Dispose();
        }
    }
}
