# airports.r
# T. J. Finney, 2011-08-08.
message("Create a distance matrix using coordinates of thirty busy airports.")

# Set parameters.
message("Output file name: ", name <- "Airports")
message("Output directory for distance matrix: ", dir_dist <- "../Distances/")
message("Output directory for MDS result: ", dir_MDS <- "../Results/CMDS/")
message("Output directory for DC result: ", dir_DC <- "../Results/DC/")
# Set writing mode: TRUE = write results; FALSE = do not write results.
message("Write mode: ", write <- TRUE)
# List airport codes and coordinates.
airports <- list(
  list(code="ATL", lat=33.64, long=-84.43),
  list(code="PEK", lat=40.08, long=116.58),
  list(code="ORD", lat=41.98, long=-87.90),
  list(code="LHR", lat=51.48, long=-0.46),
  list(code="LAX", lat=33.94, long=-118.41),
  list(code="DFW", lat=32.90, long=-97.04),
  list(code="CDG", lat=49.01, long=2.55),
  list(code="HND", lat=35.55, long=139.78),
  list(code="DEN", lat=39.86, long=-104.67),
  list(code="FRA", lat=50.03, long=8.54),
  list(code="BKK", lat=13.91, long=100.61),
  list(code="DXB", lat=25.25, long=55.36),
  list(code="HKG", lat=22.31, long=113.91),
  list(code="MAD", lat=40.47, long=-3.56),
  list(code="JFK", lat=40.64, long=-73.78),
  list(code="CGK", lat=-6.13, long=106.66),
  list(code="PHX", lat=33.43, long=-112.01),
  list(code="SIN", lat=1.36, long=103.99),
  list(code="CAN", lat=23.18, long=113.27),
  list(code="AMS", lat=52.31, long=4.76),
  list(code="LAS", lat=36.08, long=-115.15),
  list(code="IAH", lat=29.98, long=-95.34),
  list(code="CLT", lat=35.21, long=-80.94),
  list(code="MCO", lat=28.43, long=-81.32),
  list(code="PVG", lat=31.14, long=121.81),
  list(code="MIA", lat=25.79, long=-80.29),
  list(code="KUL", lat=2.75, long=101.71),
  list(code="SFO", lat=37.62, long=-122.37),
  list(code="SYD", lat=-33.95, long=151.18),
  list(code="MUC", lat=48.35, long=11.79)
)

# Functions

# tunnel_dist(P1, P2)
# Tunnel distance between two points on earth's surface, accurate to 0.5%
# P1: code, latitude and logitude of first point.
# P2: code, latitude and logitude of second point.
# Return: The the tunnel distance between P1 and P2.

tunnel_dist <- function(P1, P2) {
  lat1 <- P1[[2]]*pi/180
  long1 <- P1[[3]]*pi/180
  lat2 <- P2[[2]]*pi/180
  long2 <- P2[[3]]*pi/180
  dx <- cos(lat2)*cos(long2) - cos(lat1)*cos(long1)
  dy <- cos(lat2)*sin(long2) - cos(lat1)*sin(long1)
  dz <- sin(lat2) - sin(lat1)
  round(6372.8*(dx^2 + dy^2 + dz^2)^0.5)
}

# Script

N <- length(airports)
names <- vector(length=N)
distances <- matrix(nrow=N, ncol=N)
for (i in 1:N) {
  names[i] <- airports[[i]][[1]]
  for (j in 1:N) {
    distances[i, j] <- tunnel_dist(airports[[i]], airports[[j]])
  }
}
rownames(distances) <- colnames(distances) <- names

# Convert distance matrix to a distance object.
distances <- as.dist(distances)
#  Shut down open graphics devices.
graphics.off()

# Perform MDS analysis.
MDS <- cmdscale(distances, k=3, eig=TRUE)
x <- MDS$points[,1]
y <- MDS$points[,2]
z <- MDS$points[,3]
require(rgl)
plot3d(x, y, z, xlab="axis 1", ylab="axis 2", zlab="axis 3", type='n', axes=TRUE, box=TRUE)
text3d(x, y, z, rownames(MDS$points), col=4)
message("Proportion of variance: ", round(MDS$GOF[1], digits = 4))

# Perform DC analysis.
require(cluster)
DC <- diana(distances)
message("Divisive coefficient: ", round(DC$dc, digits = 2))
plot(DC, which=2, main="", cex=0.8)

# Write results.
if (write) {
  outdist <- paste(c(dir_dist, name), collapse="")
  outdist <- paste(c(outdist, "csv"), collapse=".")
  outDC <- paste(c(dir_DC, name), collapse="")
  outDC <- paste(c(outDC, "png"), collapse=".")
  write.csv(round(as.matrix(distances), digits=3), outdist)
  movie3d(spin3d(rpm=10), duration=6, dir=dir_MDS, movie=name)
  dev.print(png, file=outDC, width=975, height=600)
}