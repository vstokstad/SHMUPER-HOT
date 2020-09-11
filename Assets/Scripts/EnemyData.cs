using UnityEngine;

[DefaultExecutionOrder(-1100)]
[CreateAssetMenu(fileName = "New Enemy Data", menuName = "Scriptable/EnemyData", order = 1)]
public class EnemyData : ScriptableObject {
    [Header("Statistics")] public static float health = 1f;
    [Header("Move")] [Range(4, 12)] public static float moveSpeed = 12f;
    [Header("Weapons")] public static float crashDamage = 0.5f;
}