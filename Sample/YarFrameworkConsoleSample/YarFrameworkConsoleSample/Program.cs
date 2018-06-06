using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yar.Core;
using System.Runtime.InteropServices;
using System.IO;
using System.Reflection;

namespace YarFrameworkConsoleSample
{
    class Program
    {
        static ConsoleHandler _handle = new ConsoleHandler(OnControlEvent);
        static void Main(string[] args)
        {
            SetConsoleCtrlHandler(_handle, true);
            //AppDomain.CurrentDomain.AssemblyResolve += CurrentDomain_AssemblyResolve;
            //YarSystem.Init("YarApp.config");
            YarSystem.Init(YarSystem.AppModelEnum.Local, Path.GetDirectoryName(typeof(YarSystem).Assembly.CodeBase).Replace(@"file:\", ""), null);
            YarSystem.WriteLog("--------------------------------------------");
            YarSystem.Current.Start();
            CommandLine();
            YarSystem.Current.Stop();
        }

        static Assembly CurrentDomain_AssemblyResolve(object sender, ResolveEventArgs args)
        {
            if (args.Name.StartsWith("Newtonsoft.Json"))
            {
                string path = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Ref\");
                path = System.IO.Path.Combine(path, args.Name.Split(',')[0]);
                path = String.Format(@"{0}.dll", path);
                return System.Reflection.Assembly.LoadFrom(path);
            }
            return null;
        }

        private static void CommandLine()
        {
            string line;
            while ((line = Console.ReadLine()) != null)
            {
                if (line == "exit") break;
            }
        }

        // The console events...
        public enum ConsoleEvent
        {
            CTRL_C = 0,
            CTRL_BREAK = 1,
            CTRL_CLOSE = 2,
            CTRL_LOGOFF = 5,
            CTRL_SHUTDOWN = 6
        }

        // The console event handler...
        private delegate bool ConsoleHandler(ConsoleEvent sig);

        // The imported API method...
        [DllImport("kernel32.dll")]
        static extern bool SetConsoleCtrlHandler(ConsoleHandler e, bool add);

        // Control Event Handler
        public static bool OnControlEvent(ConsoleEvent consoleEvent)
        {
            bool handled = false;
            switch (consoleEvent)
            {
                case ConsoleEvent.CTRL_SHUTDOWN:
                case ConsoleEvent.CTRL_CLOSE:
                    try
                    {
                        YarSystem.Current.Stop(); handled = true;
                    }
                    catch (Exception ex)
                    {
                        YarSystem.WriteLog(ex.ToString());
                    }
                    break;
                default:
                    return handled;
            }
            return handled;
        }
    }
}
