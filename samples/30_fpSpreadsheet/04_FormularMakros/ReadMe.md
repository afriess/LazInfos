Ein Stolperstein kann auch sein, dass beim Kopieren einer Zelle (inkl Formel) die Formel geprüft wird, was ein Problem macht, wenn die Formel einen Platzhalter enthält. Hier kannst du vor dem Kopieren die Formel auslesen, sichern, durch etwas Unverfängliches ersetzen (z.B. "=A1"), die Zelle kopieren und die Formel dann wiederherstellen. Zum Glück sind die Zellen in fpspreadsheet einfache Records, so dass man (natürlich mit Bedacht) die Inhalte verändern kann, ohne einen Haufen Aktionen zu triggern (was eigentlich nicht ganz sauber ist, aber hier ist es von Vorteil).

Das geschieht so in dem beigefügten Beispiel. Hier steht in Zelle B1 die Formel "SUM(A1:#(RANGEEND))", wobei #(RANGEEND) ein Platzhalter für die außerhalb im Edit eingegebene Zelladresse ist. Ein Klick auf ">>" kopiert alle Zellen vom Template links ins Grid rechts, ersetzt den Platzhalter und berechnet die Formel.
wp_xyz
 
Source: german Lazarusforum http://www.lazarusforum.de/viewtopic.php?f=18&t=10824&p=95476#p95476