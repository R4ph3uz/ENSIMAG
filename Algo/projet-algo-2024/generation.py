import random

def generate_polygon(num_points):
    polygon = []
    for _ in range(num_points):
        x = random.randint(0, 20)
        y = random.randint(0, 20)
        polygon.append((x, y))
    
    # Fermer le polygone si nécessaire
    if num_points < 3 or polygon[0] != polygon[-1]:
        polygon.append(polygon[0])
    
    return polygon

def segments_intersect(p1, q1, p2, q2):
    def orientation(p, q, r):
        val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])
        if val == 0: return 0
        return 1 if val > 0 else 2
    
    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, q2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)
    
    if o1 != o2 and o3 != o4:
        return True
    
    if o1 == 0 and on_segment(p1, p2, q1): return True
    if o2 == 0 and on_segment(p1, q2, q1): return True
    if o3 == 0 and on_segment(p2, p1, q2): return True
    if o4 == 0 and on_segment(p2, q1, q2): return True
    
    return False

def on_segment(p, q, r):
    if q[0] <= max(p[0], r[0]) and q[0] >= min(p[0], r[0]) and q[1] <= max(p[1], r[1]) and q[1] >= min(p[1], r[1]):
        return True
    return False

def is_intersecting(polygons, new_polygon):
    for polygon in polygons:
        for i in range(len(polygon) - 1):
            x1, y1 = polygon[i]
            x2, y2 = polygon[i + 1]
            
            for j in range(len(new_polygon) - 1):
                x3, y3 = new_polygon[j]
                x4, y4 = new_polygon[j + 1]
                
                if segments_intersect((x1, y1), (x2, y2), (x3, y3), (x4, y4)):
                    return True
                
    for i in range(len(new_polygon) - 1):
        for j in range(i + 2, len(new_polygon) - 1):
            x1, y1 = new_polygon[i]
            x2, y2 = new_polygon[i + 1]
            x3, y3 = new_polygon[j]
            x4, y4 = new_polygon[j + 1]
            
            if segments_intersect((x1, y1), (x2, y2), (x3, y3), (x4, y4)):
                return True
                
    return False

def main():
    num_polygons = 10
    polygons = []
    
    for _ in range(num_polygons):
        while True:
            num_points = random.randint(3, 6)  # Random number of points between 3 and 6
            new_polygon = generate_polygon(num_points)
            
            if not is_intersecting(polygons, new_polygon):
                polygons.append(new_polygon)
                break
    
    with open("polygons.txt", "w") as file:
        for i, polygon in enumerate(polygons):
            for point in polygon:
                file.write
