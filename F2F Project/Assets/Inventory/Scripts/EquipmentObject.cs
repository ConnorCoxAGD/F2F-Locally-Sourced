using UnityEngine;
[CreateAssetMenu(fileName = "New Equipment Object", menuName = "Inventory System/Items/Equipment")]

public class EquipmentObject : ItemObject
{
    public float atkBonus, defBonus, spdBonus;

    public void Awake()
    {
        type = ItemType.Equipment;
    }
    
}
