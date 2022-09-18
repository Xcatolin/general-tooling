using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CaesarCipher {
    internal class Program {
        static void Main(string[] args) {

            // <generated_shellcode>
            byte[] encoded = new byte[buf.Length];
            for (int i = 0; i < buf.Length; i++) {
                encoded[i] = (byte)(((uint)buf[i] + 2) & 0xFF);
            }

            StringBuilder hex = new StringBuilder(encoded.Length * 2);
            foreach (byte b in encoded) { 
                hex.AppendFormat("0x{0:x2}, ", b);
            }

            Console.WriteLine(hex.ToString());
        }
    }
}
