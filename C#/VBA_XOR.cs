using System;
using System.Text;

namespace XOR {
    internal class Program {
        static void Main(string[] args) {
            byte[] buf = new byte[] { }; //Generated shellcode
            byte[] encoded = new byte[buf.Length];
            char[] key = { 'k', 'e', 'y' };
            int n = 0;

            for (int i = 0; i < buf.Length; i++) {
                if (n == key.Length) {
                    n = 0;
                }
                encoded[i] = (byte)(((uint)buf[i] ^ Convert.ToByte(key[n]) & 0xFF));
                n++;
            }

            uint counter = 0;
            StringBuilder hex = new StringBuilder(encoded.Length * 2);
            foreach(byte b in encoded) {
                hex.AppendFormat("{0:D}, ", b);
                counter++;
                if(counter % 50 == 0) {
                    hex.AppendFormat("_{0}", Environment.NewLine);
                }
            }

            string final = hex.ToString();

            Console.WriteLine(final);
        }
    }
}
