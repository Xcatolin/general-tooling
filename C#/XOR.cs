using System;
using System.Text;

namespace XOR {
    internal class Program {
        static void Main(string[] args) {
            byte[] buf = new byte[] {}; //Generated shellcode
            byte[] encoded = new byte[buf.Length];
            char[] key = { 'k', 'e', 'y' };
            int n = 0;

            for (int i = 0; i < buf.Length; i++) {
                if (n == key.Length) {
                    n = 0;
                }
                encoded[i] = (byte)(buf[i] ^ Convert.ToByte(key[n]));
                n++;
            }

            StringBuilder hex = new StringBuilder(encoded.Length * 2);
            int len = buf.Length;
            for (int i = 0; i < buf.Length; i++) {
                byte b = encoded[i];
                //Avoid extra comma
                if ((i + 1) == len) {
                    hex.AppendFormat("0x{0:x2}", b);
                } else {
                    hex.AppendFormat("0x{0:x2}, ", b);
                }
            }

            string final = hex.ToString();

            Console.WriteLine(final);
        }
    }
}
